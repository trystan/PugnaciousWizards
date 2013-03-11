package  
{
	import flash.geom.Point;
	
	public class MagicBlink implements Magic
	{
		public function playerCast(creature:Creature):void
		{
			var tries:int = 0;
			
			while (tries++ < 100)
			{
				var targetX:int = creature.x + Math.floor(Math.random() * 18) - 9;
				var targetY:int = creature.y + Math.floor(Math.random() * 18) - 9;
				
				if (targetX < 0 || targetX > 78 || targetY < 0 || targetY > 78)
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
					creature.x = targetX;
					creature.y = targetY;
					return;
				}
			}
		}
	}
}