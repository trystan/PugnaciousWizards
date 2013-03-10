package org.microrl.architecture
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	/**
	 * A base class that simplifies what microrl does: input, output, persistance, and screen switching.
	 */
	public class BaseScreen implements Screen
	{
		public static var defaultBindings:Bindings = new BaseBindings();
		
		protected var lastKeyboardEvent:KeyboardEvent;
		protected var lastMouseEvent:MouseEvent;
		protected var bindings:Bindings;
		protected var gui:Array;
		protected var session:SharedObject;
		
		/**
		 * Create a screen that handles user input and output.
		 * @param	bindings	Optional predefined keybindings. Mapping "wsad" and keys to movement, etc. Defaults to a copy of BaseScreen.defaultBindings.
		 * @param	gui			Optional predefined array of Viewable components. StatusBar, ScreenEffect, WorldView, etc. Defaults to an empty array.
		 * @param	session		Optional predefined Session. Defaults to a local SharedObject session named "session".
		 */
		public function BaseScreen(bindings:Bindings = null, gui:Array = null, session:SharedObject = null)
		{
			if (bindings == null)
				bindings = defaultBindings.copy();
			
			if (gui == null)
				gui = [];
			
			if (session == null)
				session = SharedObject.getLocal("session", "/", false);
				
			this.bindings = bindings;
			this.gui = gui;
			this.session = session;
		}
		
		/**
		 * Translate user input into intent and behavior.
		 * If user input isn't bound to an intent, then unhandledInput will be called.
		 * If an intent isn't bound to a behavior, then unhandledIntent will be called.
		 * @param	input		The key pressed. "F", "space", "c", etc.
		 * @param	intent		What that input represents. "start", "move N", "look", etc.
		 * @param	behavior	Optional function to call with the intent args.
		 * @param	args		Optional function arguments.
		 */
		public function bind(input:String, intent:String, behavior:Function = null, ... args):void
		{
			if (input != null && intent != null)
				bindings.bindInput(input, intent);
			
			if (intent != null && behavior != null)
				bindings.bindIntent(intent, function():void { Util.callFunc(behavior, args) } );
				
			if (input == null && intent == null)
				throw new ArgumentError("Must bind input to intent, intent to behavior, or all at once.");
		}
		
		public function handleKeyboardInput(keyEvent:KeyboardEvent):void 
		{
			lastKeyboardEvent = keyEvent;
			
			var key:String = String.fromCharCode(keyEvent.charCode);
			switch (keyEvent.keyCode)
			{
				case 8: key = "backspace"; break;
				case 9: key = "tab"; break;
				case 13: key = "enter"; break;
				case 20: key = "caps lock"; break;
				case 27: key = "escape"; break;
				case 37: key = "left"; break;
				case 39: key = "right"; break;
				case 38: key = "up"; break;
				case 40: key = "down"; break;
			}
			
			var parts:Array = [];
			
			if (keyEvent.ctrlKey)
				parts.push("control");
			if (keyEvent.altKey)
				parts.push("alt");
			if (keyEvent.shiftKey && (key.length > 1 || keyEvent.keyCode == 16))
				parts.push("shift");
			if (keyEvent.keyCode != 16 && keyEvent.keyCode != 17)
				parts.push(key);
			
			handleInput(parts.join("+"));
		}
		
		public function handleMouseInput(eventType:String, mouseEvent:MouseEvent):void
		{
			lastMouseEvent = mouseEvent;
			handleInput(eventType);
		}
		
		protected function handleInput(input:String):void
		{
			var intent:String = bindings.intentForInput(input) as String;
			var behavior:Function = bindings.behaviorForIntent(intent);
			
			if (intent == null)
				unhandledInput(input);
			else if (behavior == null)
				unhandledIntent(intent);
			else
				handleIntent(intent, behavior);
		}
		
		/**
		 * Called when the user input isn't bound to any intent.
		 * 
		 * @param	input	The user input. "#", "escape", "<", etc.
		 */
		protected function unhandledInput(input:String):void
		{
			trace("[RL] unhandled input: " + input);
		}
		
		/**
		 * Called when the user's intent isn't bound to any behavior.
		 * 
		 * @param	intent	The user's intent. "moveUp", "zap", "quit", etc.
		 */
		protected function unhandledIntent(intent:String):void
		{
			trace("[RL] unhandled intent: " + intent);
		}
		
		/**
		 * Called when the user's intent is bound to a behavior.
		 * 
		 * @param	intent		The user's intent. "moveUp", "zap", "quit", etc.
		 * @param	behavior	The funciton that makes it happen. moveUp, zap, quit, etc.
		 */
		protected function handleIntent(intent:String, behavior:Function):void
		{
			behavior();
		}
		
		
		/**
		 * Add a viewable object of function to the screen.
		 * 
		 * @param	viewable	The View object or function of type "function (terminal:AsciiPanel):void". A view of the world, a status bar, hud text, etc.
		 */
		public function display(view:Object):void
		{
			if (view is Function)
				gui.push(new ViewFunction(view as Function));
			else if (view is View)
				gui.push(view);
			else
				throw new ArgumentError("'viewable' must implement View or be a function of type \"function (terminal:AsciiPanel):void\"");
		}
		
		public function handleAsciiOutput(terminal:AsciiPanel):void 
		{
			for each (var view:View in gui)
				view.viewOn(terminal);
		}
		
		
		/**
		 * Stop using the current screen and use a different one instead. The current one will no longer recieve user input or display.
		 * 
		 * @param	next	The screen to use instead of the current one. DeadScreen, ChooseNewSkillScreen, EatScreen, etc.
		 */
		protected function switchToScreen(next:Screen):void
		{
			RL.switchToScreen(next);
		}
		
		/**
		 * Display a child screen on top of this one. The current one will no longer recieve user input but still display.
		 * 
		 * @param	next	The screen to use on top of the current one. PlayScreen, QuaffScreen, HelpScreen, etc.
		 */
		protected function enterScreen(next:Screen):void
		{
			RL.enterScreen(next);
		}
		
		/**
		 * Stop using the current screen and fall back to the parent one instead. The current one will no longer recieve user input or display.
		 */
		protected function exitScreen():void
		{
			RL.exitScreen();
		}
	}
}