package  
{
	public class Guard extends Creature 
	{
		public function Guard(x:int, y:int) 
		{
			super("g", Color.hsv(0, 10, 80), x, y);
			
			meleeAttack = 10;
			meleeDefence = 5;
			hp = 50;
		}
		
		override public function updateInternal():void
		{
			if (world.getRoom(x, y).contains(world.hero))
			{
				var mx:int = x < world.hero.x ? 1 : (x > world.hero.x ? -1 : 0);
				var my:int = y < world.hero.y ? 1 : (y > world.hero.y ? -1 : 0);
				
				walk(mx, my);
			}
			else
			{
				wander();
			}
		}
	}
}