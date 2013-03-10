package org.microrl.architecture
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class RL extends Sprite
	{
		private static var terminal:AsciiPanel;
		private static var screenStack:Array = [];
	
		public static var instance:RL;
		
		public function RL(firstScreen:Screen, displayTerminal:AsciiPanel = null)
		{
			instance = this;
			
			if (displayTerminal == null)
				displayTerminal = new AsciiPanel();
			
			terminal = displayTerminal;
			screenStack = [firstScreen];
			
			addChild(terminal);
				
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardEvent);
			stage.addEventListener(MouseEvent.CLICK, handleMouseEventClick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseEventDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseEventUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseEventMove);
			paint();
		}
		
		public function handleKeyboardEvent(keyEvent:KeyboardEvent):void
		{
			screenStack[0].handleKeyboardInput(keyEvent);
			paint();
		}
		
		public function handleMouseEventClick(mouseEvent:MouseEvent):void
		{
			screenStack[0].handleMouseInput("MouseClick", mouseEvent);
			paint();
		}
		public function handleMouseEventDown(mouseEvent:MouseEvent):void
		{
			screenStack[0].handleMouseInput("MouseDown", mouseEvent);
			paint();
		}
		public function handleMouseEventUp(mouseEvent:MouseEvent):void
		{
			screenStack[0].handleMouseInput("MouseUp", mouseEvent);
			paint();
		}
		public function handleMouseEventMove(mouseEvent:MouseEvent):void
		{
			screenStack[0].handleMouseInput("MouseMove", mouseEvent);
			paint();
		}
		
		public static function reset():void
		{
			RL.screenStack = [];
		}
		
		protected static function paint():void
		{
			for (var i:int = screenStack.length - 1; i >= 0; i--)
				screenStack[i].handleAsciiOutput(terminal);
			
			terminal.paint();
		}
		
		
		public static function switchToScreen(next:Screen):void
		{
			screenStack[0] = next;
		}
		
		public static function enterScreen(next:Screen):void
		{
			screenStack.unshift(next);
		}
		
		public static function exitScreen():void
		{
			screenStack.shift();
		}
	}
}