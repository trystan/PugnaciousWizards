package  
{
	public class Knight extends Creature 
	{
		public function Knight(x:int, y:int) 
		{
			super("k", Color.hsv(200, 20, 90), x, y);
			
			meleeAttack = 20;
			meleeDefence = 10;
			hp = 80;
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