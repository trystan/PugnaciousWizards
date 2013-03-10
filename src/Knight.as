package  
{
	public class Knight extends Creature 
	{
		public function Knight(x:int, y:int) 
		{
			super("k", Color.hsv(200, 40, 60), x, y);
			
			meleeAttack = 20;
			meleeDefence = 10;
			hp = 80;
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