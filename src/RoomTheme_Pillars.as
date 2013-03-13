package  
{
	public class RoomTheme_Pillars implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.description = "Abandoned room";
				
			var total:int = Math.floor(Math.random() + 2 + Math.random() + 2) + 1;
			for (var i:int = 0; i < total; i++)
			{
				var x:int = room.x * 8 + 5 + Math.floor(Math.random() * 5) + 1;
				var y:int = room.y * 8 + 5 + Math.floor(Math.random() * 5) + 1;
				
				world.setTile(x, y, Tile.crumbledWall);
			}
		}
	}
}