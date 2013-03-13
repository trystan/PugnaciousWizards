package  
{
	import org.microrl.architecture.RL;
	
	public class HelpSystem 
	{
		private static var events:Array = [];
		public static var enabled:Boolean = true;
		
		public static function notify(creature:Creature, event:String, details:String):void
		{
			if (!enabled || !(creature is Player))
				return;
				
			if (events.indexOf(event) > -1)
				return;
				
			events.push(event);
			creature.world.addAnimation(new HelpSystemPopupScreen(event, details));
		}
	}
}