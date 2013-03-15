package triggers 
{
	public class AndTrigger implements Trigger
	{
		public var triggerList:Array;
		
		public function AndTrigger(triggerList:Array)
		{
			this.triggerList = triggerList;
		}
		
		public function check(world:World):Boolean
		{			
			for each (var trigger:Trigger in triggerList)
			{
				if (!trigger.check(world))
					return false;
			}
			return true;
		}
	}
}