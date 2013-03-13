package  
{
	public class Skeleton extends Creature 
	{
		public function Skeleton(x:int, y:int) 
		{
			super("s", Color.hsv(90, 00, 66), x, y, "skeleton");
			
			meleeAttack = 10;
			meleeDefence = 0;
			hp = 5;
		}
		
		override public function bleed():void
		{	
		}
		
		override public function updateInternal():void
		{
			if (isBlind)
			{
				wander();
				return;
			}
			
			for (var ox:int = -1; ox < 2; ox++)
			for (var oy:int = -1; oy < 2; oy++)
			{
				var other:Creature = world.getCreature(x + ox, y + oy);
				
				if (doesHate(other))
				{
					walk(other.x - x, other.y - y);
					return;
				}
			}
			
			wander();
		}
	}
}