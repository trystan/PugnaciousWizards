package  
{
	import org.microrl.architecture.RL;
	
	public class MagicMissile implements Magic
	{
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			var candidates:Array = [];
			for each (var dir:Array in dirs)
			{
				var candidate:MagicAction = getCandidate(caster, dir[0], dir[1]);
				if (candidate != null)
					candidates.push(candidate);
			}
			
			if (candidates.length > 0)
				return candidates[Math.floor(Math.random() * candidates.length)];
				
			return new MagicAction(0, function(c:Creature):void {
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			RL.enterScreen(new TargetDirectionScreen(function(mx:int, my:int):void {
				creature.world.addAnimation(new MagicMissileAnimation(creature.world, creature.x, creature.y, mx, my, creature.viewDistance));
			}));
		}
		
		private function getCandidate(caster:Creature, ox:int, oy:int):MagicAction 
		{
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
				
				if (!caster.doesHate(target))
					continue;
				
				return new MagicAction(50, function(c:Creature):void {
					c.world.addAnimation(new MagicMissileAnimation(c.world, c.x, c.y, ox, oy, c.viewDistance));
				});
			}
			return null;
		}
	}
}