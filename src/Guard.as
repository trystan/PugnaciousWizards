package  
{
	public class Guard extends Creature 
	{
		public function Guard(x:int, y:int) 
		{
			super("g", Color.hsv(90, 50, 50), x, y);
		}
		
		override public function doAi():void
		{
			wander();
		}
	}
}