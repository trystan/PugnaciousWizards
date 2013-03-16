package  
{
	import flash.geom.Point;
	import traps.Trap;
	import triggers.HeroInRoom;
	public class RoomTheme_RotatingTowers implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
			
			var total:int = Math.max(1, Math.min(room.dist / 8, 4));
			
			var rows:Array = [1, 2, 3, 5, 6, 7];
			var cols:Array = [1, 2, 3, 5, 6, 7];
			var towers:Array = [];
			
			if (Math.random() < 0.75)
				addPillar(world, room);
				
			for (var i:int = 0; i < total; i++)
			{
				var row:int = rows[Math.floor(Math.random() * rows.length)];
				var col:int = cols[Math.floor(Math.random() * cols.length)];
				
				var x:int = room.x * 8 + 4 + row;
				var y:int = room.y * 8 + 4 + col;
				
				world.setTile(x, y, Tile.rotatingTower1);
				towers.push(new Point(x, y));
				
				rows.splice(rows.indexOf(row), 1);
				cols.splice(rows.indexOf(col), 1);
			}
			
			var trap:Trap = new Trap(new HeroInRoom(room), new RotatingTowersAnimation(world, towers));
			
			world.addTriggerForEveryTurn(function():void {
				trap.check(world);
			});
			
			addBlood(world, room, towers.length * 4);
		}
		
		public function addPillar(world:World, room:Room):void
		{
			var x:int = room.x * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			var y:int = room.y * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			
			world.setTile(x, y, Tile.wall);
			
			if (Math.random() < 0.2)
				addPillar(world, room);
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