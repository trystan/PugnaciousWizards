package  
{
	import flash.geom.Point;
	
	public class RoomTheme_Portal implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
			
			room.hasTheme = true;
			room.description = "Portal room";
			
			var x:int = room.x * 8 + 8;
			var y:int = room.y * 8 + 8;
			
			world.setTile(x, y, Tile.portal);
			world.addTriggerForEveryTurn(function() {
				world.setTile(x, y, Tile.portal);
				if (world.hero.x == x && world.hero.y == y)
					teleport(world.hero);
			});
		}
		
		private function teleport(target:Creature):void
		{
			var tiles:Array = [];
			
			for (var x:int = 0; x < 80; x++)
			for (var y:int = 0; y < 80; y++)
			{
				if (target.world.getTile(x, y).isPortal)
				{					
					var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
									  [ -1, -0],            [ +1, -0],
									  [ -1, +1], [ -0, +1], [ +1, +1]];
									  
					for each (var offset:Array in dirs)
					{
						if (target.world.getTile(x + offset[0], y + offset[1]).isWalkable
						 && target.world.getCreature(x + offset[0], y + offset[1]) == null)
							tiles.push(new Point(x + offset[0], y + offset[1]));
					}
				}
			}
			
			if (tiles.length < 2)
				return;
			
			var dest:Point = tiles[Math.floor(Math.random() * tiles.length)];
			
			target.teleportTo(dest.x, dest.y);
		}
	}
}