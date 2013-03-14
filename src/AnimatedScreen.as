package  
{
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class AnimatedScreen extends BaseScreen
	{
		private var intervalTimeout:int;
		
		public function AnimatedScreen() 
		{
			
		}
		
		protected function animate(fps:int):void 
		{
			animateWith(fps, 46);
		}
		
		protected function animateWith(fps:int, keyCode:int):void 
		{
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, keyCode, 190);
			intervalTimeout = setInterval(RL.instance.handleKeyboardEvent, 1000 / fps, event);
		}
		
		override protected function exitScreen():void 
		{
			clearInterval(intervalTimeout);
			
			super.exitScreen();
		}
	}
}