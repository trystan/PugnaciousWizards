package  
{
	public class RoomTheme_A implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Archer barracks";
			room.description = "An archer barracks will respawn archers if there arent enough. Ther farther you venture into the castle the more archers each barracks will hold.";
			
			var blueprint:Array = [
				"0000000",
				"0111100",
				"0000010",
				"0111110",
				"1000010",
				"0111111",
				"0000000",
			];
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				var t:Tile = blueprint[oy].charAt(ox) == "0" ? Tile.tile1 : Tile.tile3;
				
				world.setTile(x, y, t);
			}
			
			world.addTriggerForEveryTurn(function():void {
				if (Math.random() > 0.05)
					return;
				
				var x0 = room.x * 8 + 5;
				var y0 = room.y * 8 + 5;
				var x1 = room.x * 8 + 5 + 7;
				var y1 = room.y * 8 + 5 + 7;
				
				var archerCount:int = 0;
				
				for each (var creature:Creature in world.creatures)
				{
					if (creature is Archer && room.contains(creature))
						archerCount++;
				}
				
				if (archerCount >= Math.floor(room.dist / 5) + 1)
					return;
				
				var tries:int = 49;
				while (tries-- > 0)
				{
					var cx:int = x0 + Math.random() * 7;
					var cy:int = y0 + Math.random() * 7;
					
					if (!world.getTile(cx, cy).isWalkable)
						continue;
						
					if (world.getCreature(cx, cy) != null)
						continue;
						
					world.addCreature(new Archer(x, y));
					break;
				}
			});
		}
	}
}