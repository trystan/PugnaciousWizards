package triggers 
{
	public class RandomPercentOfTheTime implements Trigger
	{
		public var percent:int;
		
		public function RandomPercentOfTheTime(percent:int)
		{
			this.percent = percent;
		}
		
		public function check(world:World):Boolean
		{
			return Math.random() < percent / 100.0;
		}
	}
}