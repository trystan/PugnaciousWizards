package  
{
	import flash.geom.Point;
	import triggers.HeroInRoom;
	public class RoomTheme_ArrowTowers implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
			
			var total:int = Math.max(1, Math.min(room.dist / 5 + 1, 4));
			
			var rows:Array = [1, 2, 3, 5, 6, 7];
			var cols:Array = [1, 2, 3, 5, 6, 7];
			var towers:Array = [];
			
			if (Math.random() < 0.75)
				room.addPillar(world);
				
			for (var i:int = 0; i < total; i++)
			{
				var row:int = rows[Math.floor(Math.random() * rows.length)];
				var col:int = cols[Math.floor(Math.random() * cols.length)];
				
				var x:int = room.x * 8 + 4 + row;
				var y:int = room.y * 8 + 4 + col;
				
				world.setTile(x, y, Tile.arrowTower);
				towers.push(new Point(x, y));
				
				rows.splice(rows.indexOf(row), 1);
				cols.splice(rows.indexOf(col), 1);
			}
			
			var trigger:HeroInRoom = new HeroInRoom(room);
			
			world.addTriggerForEveryTurn(function():void {
				if (trigger.check(world))
					world.addAnimation(new ArrowTowersAnimation(world, towers));
			});
			
			room.addBlood(world, towers.length * 3);
		}
	}
}