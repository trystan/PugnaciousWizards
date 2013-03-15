package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.RL;
	
	public class Composite implements Animation 
	{
		private var deliveries:Array = [];
		
		public function Composite(deliveries:Array) 
		{
			this.deliveries = deliveries;
		}
		
		public function get isDone():Boolean 
		{
			return deliveries.length == 0;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			if (deliveries.length > 0)
			{
				deliveries[0].tick(terminal);
				
				if (deliveries[0].isDone)
					deliveries.shift();
			}
		}
	}
}