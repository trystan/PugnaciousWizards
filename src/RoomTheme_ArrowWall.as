package  
{
	import flash.geom.Point;
	import traps.Trap;
	import triggers.AndTrigger;
	import triggers.HeroInRoom;
	import triggers.RandomPercentOfTheTime;
	import triggers.Trigger;
	public class RoomTheme_ArrowWall implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
			
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
			
			var trap:Trap = new Trap(
								new AndTrigger([new HeroInRoom(room), new RandomPercentOfTheTime(25)]), 
								new WallOfArrowsAnimation(world, walls, ox, oy));
			
			world.addTriggerForEveryTurn(function():void {
				trap.check(world);
			});
			
			addBlood(world, room, 5);
		}
		
		public function addBlood(world:World, room:Room, amount:int):void
		{
			var max:int = world.maxBloodPerTile * 49;
			var total:int = max * amount / 100.0;
			for (var i:int = 0; i < total; i++)
			{
				var x:int = room.x * 8 + 4 + Math.floor(Math.random() * 9);
				var y:int = room.y * 8 + 4 + Math.floor(Math.random() * 9);
				
				world.addBlood(x, y);
			}
		}
	}
}