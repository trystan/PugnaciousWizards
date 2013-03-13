package  
{
	public class Guard extends Creature 
	{
		public function Guard(x:int, y:int) 
		{
			super("g", Color.hsv(0, 10, 80), x, y, "guard",
				"Their heavy armor and sword means guards can cause a lot of pain and withstand a lot of pain.");
			
			meleeAttack = 15;
			meleeDefence = 6;
			hp = 40;
		}
		
		override public function updateInternal():void
		{
			if (isBlind)
			{
				wander();
				return;
			}
			
			var room:Room = world.getRoom(x, y);
			if (room != null && room.contains(world.hero))
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