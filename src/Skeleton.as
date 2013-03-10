package  
{
	public class Skeleton extends Creature 
	{
		public function Skeleton(x:int, y:int) 
		{
			super("s", Color.hsv(90, 00, 66), x, y);
			
			meleeAttack = 10;
			meleeDefence = 0;
			hp = 5;
		}
		
		override public function update():void
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