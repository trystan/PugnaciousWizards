package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.RL;
	
	public class Instant extends AnimatedScreen 
	{
		private var intervalTimeout:int;
		
		public function Instant(world:World, x:int, y:int, magicEffect:Effect) 
		{
			display(function(terminal:AsciiPanel):void {
				magicEffect.applyPrimary(world, x, y);
			});
			
			bind(".", "animate", function():void {
				exitScreen();
			});
			
			intervalTimeout = setInterval(stepOnce, 1000 / 30);
		}
		
		public function stepOnce():void
		{
			clearInterval(intervalTimeout);
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 46, 190);
			RL.instance.handleKeyboardEvent(event);
		}
	}
}