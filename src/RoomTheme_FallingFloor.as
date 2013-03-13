package  
{
	import flash.geom.Point;
	
	public class RoomTheme_FallingFloor implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.description = "Old room";
			
			var previousTiles:Array = [];
			world.addTriggerForEveryTurn(function():void {
				while (previousTiles.length > 1)
				{
					var p:Point = previousTiles.shift();
					world.setTile(p.x, p.y, Tile.pit);
				}
				
				if (room.contains(world.hero) && Math.random() < 0.33)
					previousTiles.push(new Point(world.hero.x, world.hero.y));
			});
		}
	}
}