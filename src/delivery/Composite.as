package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.RL;
	
	public class Composite extends AnimatedScreen 
	{
		public function Composite(deliveries:Array) 
		{	
			bind(String.fromCharCode(0), "animate", function():void {
				if (deliveries.length == 0)
					exitScreen();
				else
					enterScreen(deliveries.shift());
			});
			
			animateWith(5, 0);
		}
	}
}