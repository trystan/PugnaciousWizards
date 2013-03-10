package  
{
	public class Archer extends Creature 
	{
		public function Archer(x:int, y:int) 
		{
			super("a", Color.hsv(90, 50, 50), x, y);
			
			meleeAttack = 5;
			meleeDefence = 1;
			hp = 40;
		}
		
		override public function update():void
		{
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			for each (var dir:Array in dirs)
			{
				var ox:int = dir[0];
				var oy:int = dir[1];
				var targetX:int = x;
				var targetY:int = y;

				for (var i:int = 0; i < 9; i++)
				{
					targetX += ox;
					targetY += oy;
					
					var t:Tile = world.getTile(targetX, targetY);
					if (!t.isWalkable || t == Tile.closedDoor)
						break;
					
					var target:Creature = world.getCreature(targetX, targetY);
					
					if (target == null)
						continue;
					
					if (target.glyph == "@")
						fireArrow(ox, oy);
					
					return;
				}
			}
							  
			wander();
		}
		
		public function fireArrow(ox:int, oy:int):void
		{
			world.addAnimation(new ArrowAnimation(world, x, y, ox, oy));
		}
	}
}