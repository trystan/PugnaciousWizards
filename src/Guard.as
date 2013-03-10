package  
{
	public class Guard extends Creature 
	{
		public function Guard(x:int, y:int) 
		{
			super("g", Color.hsv(90, 50, 50), x, y);
			
			meleeAttack = 10;
			meleeDefence = 5;
			hp = 50;
		}
		
		override public function doAi():void
		{
			for (var ox:int = -1; ox < 2; ox++)
			for (var oy:int = -1; oy < 2; oy++)
			{
				var other:Creature = world.getCreature(x + ox, y + oy);
				
				if (other != null && other.glyph == "@")
				{
					walk(other.x - x, other.y - y);
					return;
				}
			}
			
			wander();
		}
	}
}