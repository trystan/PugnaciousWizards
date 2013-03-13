package  
{
	import flash.geom.Point;
	
	public class RoomTheme_Statuary implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.description = "Statuary";
			
			var triggers:Array = [];
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				if (ox % 4 == 1 && oy % 4 == 1)
				{
					var glyph:int = Math.floor(Math.random() * 26 + 97);
					world.setTile(x, y, new Tile(glyph, 0xffbbbbbb, 0xff666666, false, true, "statue of a " + String.fromCharCode(glyph)));
				}
			}
		}
	}
}