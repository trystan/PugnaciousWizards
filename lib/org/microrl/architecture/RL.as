package org.microrl.architecture
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.clearInterval;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	
	public class RL extends Sprite
	{
		public static var terminal:AsciiPanel;
		public static var screenStack:Array = [];
	
		public static var instance:RL;
		
		public var ignoreInput:Boolean = false;
		
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
		
		private var keyboardInputQueue:Array = [];
		public function handleKeyboardEvent(keyEvent:KeyboardEvent):void
		{
			if (ignoreInput)
			{
				keyboardInputQueue.push(keyEvent);
				return;
			}
				
			screenStack[0].handleKeyboardInput(keyEvent);
			paint();
			animate();
		}
		
		public function handleMouseEventClick(mouseEvent:MouseEvent):void
		{
			if (ignoreInput)
				return;
				
			screenStack[0].handleMouseInput("MouseClick", mouseEvent);
			paint();
		}
		public function handleMouseEventDown(mouseEvent:MouseEvent):void
		{
			if (ignoreInput)
				return;
				
			screenStack[0].handleMouseInput("MouseDown", mouseEvent);
			paint();
		}
		public function handleMouseEventUp(mouseEvent:MouseEvent):void
		{
			if (ignoreInput)
				return;
				
			screenStack[0].handleMouseInput("MouseUp", mouseEvent);
			paint();
		}
		public function handleMouseEventMove(mouseEvent:MouseEvent):void
		{
			if (ignoreInput)
				return;
				
			screenStack[0].handleMouseInput("MouseMove", mouseEvent);
			paint();
		}
		
		public static function reset():void
		{
			RL.screenStack = [];
		}
		
		public static function paint():void
		{
			for (var i:int = screenStack.length - 1; i >= 0; i--)
				screenStack[i].handleAsciiOutput(terminal);
			
			terminal.paint();
		}
		
		private var animations:Array = [];
		
		public function addAnimation(animation:Animation):void
		{
			animations.push(animation);
		}
		
		private var animateInterval:int = 0;
		private function animate():void
		{
			if (animations.length == 0)
				return;
			
			ignoreInput = true;
			animateInterval = setInterval(animateOneFrame, 1000 / 45);
			animatedLastFrame = false;
		}
		
		public function cancelAnimations():void
		{
			clearInterval(animateInterval);
			ignoreInput = false;
			animatedLastFrame = false;
			animations = [];
			paint();
			
			if (keyboardInputQueue.length > 0)
			{
				var event:KeyboardEvent = keyboardInputQueue.unshift() as KeyboardEvent;
				if (event != null)
					handleKeyboardEvent(event);
				keyboardInputQueue = [];
			}
		}
		
		private var animatedLastFrame:Boolean = false;
		private function animateOneFrame():void 
		{	
			paint();
			var nextAnimations:Array = [];
			while (animations.length > 0)
			{
				var animation:Animation = animations.shift();
				animation.tick(RL.terminal);
				if (!animation.isDone)
					nextAnimations.push(animation);
			}
			terminal.paint();
			animations = nextAnimations;
			
			if (animations.length == 0)
			{
				if (animatedLastFrame)
					cancelAnimations();
				else
					animatedLastFrame = true;
			}
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