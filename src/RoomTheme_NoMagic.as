package  
{
	public class RoomTheme_NoMagic implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;	
			room.forbidMagic = true;
				
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				var t:Tile = (x + y) % 2 == 0 ? Tile.tile1 : Tile.tile2;
				var c:int = Math.floor(Math.random() * 255);
				
				t = new Tile(c, 0xff222222, t.bg, t.isWalkable, t.allowsVision);
				
				world.setTile(x, y, t);
			}
		}
	}
}