package  
{
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	
	public class MagicBlink implements Magic
	{
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var total:int = 0;
			
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			for each (var offset:Array in dirs)
			{
				if (caster.doesHate(caster.world.getCreature(caster.x + offset[0], caster.y + offset[1])))
					total++;
			}

			return new MagicAction(total * 10, function(c:Creature):void {
				playerCast(caster);
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			var tries:int = 0;
			
			while (tries++ < 100)
			{
				var targetX:int = creature.x + Math.floor(Math.random() * 18) - 9;
				var targetY:int = creature.y + Math.floor(Math.random() * 18) - 9;
				
				if (targetX < 0 || targetX > 78 || targetY < 0 || targetY > 78)
					continue;
					
				if (creature.world.getCreature(targetX, targetY) != null)
					continue;
					
				var isOk:Boolean = true;
				for each (var p:Point in Line.betweenCoordinates(creature.x, creature.y, targetX, targetY).points)
				{
					if (!creature.world.getTile(p.x, p.y).isWalkable 
						|| creature.world.getTile(p.x, p.y) == Tile.closedDoor)
					{
						isOk = false;
						break;
					}
				}
				
				if (isOk)
				{
					creature.teleportTo(targetX, targetY);
					return;
				}
			}
		}
	}
}