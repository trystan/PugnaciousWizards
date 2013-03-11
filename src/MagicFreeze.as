package  
{
	import org.microrl.architecture.RL;
	
	public class MagicFreeze implements Magic
	{	
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			var directionX:int = 0;
			var directionY:int = 0;
			for each (var dir:Array in dirs)
			{
				var ox:int = dir[0];
				var oy:int = dir[1];
				var targetX:int = caster.x;
				var targetY:int = caster.y;

				for (var i:int = 0; i < caster.viewDistance; i++)
				{
					targetX += ox;
					targetY += oy;
					
					var t:Tile = caster.world.getTile(targetX, targetY);
					if (!t.allowsVision)
						break;
					
					var target:Creature = caster.world.getCreature(targetX, targetY);
					
					if (target == null || target.isFrozenCounter > 0)
						continue;
					
					directionX = ox;
					directionY = oy;
					break;
				}
			}
			
			return new MagicAction(directionX == 0 && directionY == 0 ? 0 : 50, function(c:Creature):void {
				c.world.addAnimation(new FreezeAnimation(c.world, c.x, c.y, directionX, directionY, c.viewDistance));
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			RL.enterScreen(new TargetDirectionScreen(function(mx:int, my:int):void {
				creature.world.addAnimation(new FreezeAnimation(creature.world, creature.x, creature.y, mx, my, creature.viewDistance));
			}));
		}
	}
}