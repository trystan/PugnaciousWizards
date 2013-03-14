package  
{
	public class Archer extends Creature 
	{
		public function Archer(x:int, y:int) 
		{
			super("a", Color.hsv(120, 20, 85), x, y, "archer",
				"Armed with a bow and arrows, archers can't do much damage up close but they can attack from a distance. Their light armor means they fall quickly in melee combat.");
			
			meleeAttack = 5;
			meleeDefence = 1;
			hp = 40;
		}
		
		override public function updateInternal():void
		{
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			if (isBlind)
			{
				if (Math.random() < 0.25)
				{
					var dir:Array = dirs[Math.floor(Math.random() * dirs.length)];
					fireArrow(ox, oy);
				}
				else
					wander();
				return;
			}
							  
			for each (var dir:Array in dirs)
			{
				var ox:int = dir[0];
				var oy:int = dir[1];
				var targetX:int = x;
				var targetY:int = y;

				for (var i:int = 0; i < viewDistance; i++)
				{
					targetX += ox;
					targetY += oy;
					
					var t:Tile = world.getTile(targetX, targetY);
					if (!t.allowsVision)
						break;
					
					var target:Creature = world.getCreature(targetX, targetY);
					
					if (target == null)
						continue;
					
					if (doesHate(target))
						fireArrow(ox, oy);
					
					return;
				}
			}
			
			if (canSee(world.hero) && ((world.hero.x-x)*(world.hero.x-x) + (world.hero.y-y)*(world.hero.y-y)) > 3)
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
		
		public function fireArrow(ox:int, oy:int):void
		{
			world.addAnimation(new ArrowAnimation(world, x, y, ox, oy));
		}
	}
}