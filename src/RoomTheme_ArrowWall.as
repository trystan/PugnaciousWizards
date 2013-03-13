package  
{
	import flash.geom.Point;
	public class RoomTheme_ArrowWall implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.description = "Empty room";
			
			var walls:Array = [];
			
			var wallSide:String = "NSWE".charAt(Math.floor(Math.random() * 3));
			var ox:int;
			var oy:int;
			var rx:int = room.x * 8 + 4;
			var ry:int = room.y * 8 + 4;
			
			switch (wallSide)
			{
				case "N":
					ox = 0;
					oy = 1;
					for (var x:int = 1; x < 8; x++)
					{
						if (world.getTile(rx + x, ry) == Tile.wall)
							walls.push(new Point(rx + x, ry));
					}
					break;
				case "S":
					ox = 0;
					oy = -1;
					for (var x:int = 1; x < 8; x++)
					{
						if (world.getTile(rx + x, ry + 8) == Tile.wall)
							walls.push(new Point(rx + x, ry + 8));
					}
					break;
				case "W":
					ox = 1;
					oy = 0;
					for (var y:int = 1; y < 8; y++)
					{
						if (world.getTile(rx, ry + y) == Tile.wall)
							walls.push(new Point(rx, ry + y));
					}
					break;
				case "E":
					ox = -1;
					oy = 0;
					for (var y:int = 1; y < 8; y++)
					{
						if (world.getTile(rx + 8, ry + y) == Tile.wall)
							walls.push(new Point(rx + 8, ry + y));
					}
					break;
			}
			
			world.addTriggerForEveryTurn(function():void {
				var x0 = room.x * 8 + 5;
				var y0 = room.y * 8 + 5;
				var x1 = room.x * 8 + 5 + 7;
				var y1 = room.y * 8 + 5 + 7;
				
				if (world.hero.x >= x0 && world.hero.x <= x1 
					&& world.hero.y >= y0 && world.hero.y <= y1
					&& Math.random() < 0.1)
					world.addAnimation(new WallOfArrowsAnimation(world, walls, ox, oy));
			});
		}
	}
}