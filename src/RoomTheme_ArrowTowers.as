package  
{
	import flash.geom.Point;
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
			
			world.addTriggerForEveryTurn(function():void {
				var x0 = room.x * 8 + 5;
				var y0 = room.y * 8 + 5;
				var x1 = room.x * 8 + 5 + 7;
				var y1 = room.y * 8 + 5 + 7;
				
				if (world.hero.x >= x0 && world.hero.x <= x1 && world.hero.y >= y0 && world.hero.y <= y1)
					world.addAnimation(new ArrowTowersAnimation(world, towers));
			});
		}
	}
}