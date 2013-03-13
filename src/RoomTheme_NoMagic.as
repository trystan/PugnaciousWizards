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
			room.name = "Mystical room";
			room.description = "Mystical symbols carved into the floor give you an uneasy feeling that you don't want to run into anyone in here....";
				
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				var t:Tile = (x + y) % 2 == 0 ? Tile.tile1 : Tile.tile2;
				var c:int = Math.floor(Math.random() * 255);
				
				t = new Tile(c, 0xff222222, t.bg, t.isWalkable, t.allowsVision, "floor carved with odd symbols", null);
				
				world.setTile(x, y, t);
			}
		}
	}
}