package  
{
	import flash.geom.Point;
	
	public class RoomTheme_Statuary implements RoomTheme
	{
		private var forms:Array = [
			"archer", "bat", "bear", "cat", "centaur", "dog", "donkey", "elephant", "fish", "fighter", "goon", "horse",
			"imp", "jaguar", "joker", "king", "knight", "lion", "moon", "monster", "ninja", "oragutan", "paladin", 
			"queen", "rogue", "skeleton", "stalker", "toad", "troll", "unicorn", "vampire", "wherewolf", "xom follower",
			"yeti", "zombie"
		];
		
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Statuary";
			
			var triggers:Array = [];
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				if (ox % 4 == 1 && oy % 4 == 1)
				{
					var glyph:int = Math.floor(Math.random() * 26 + 97);
					world.setTile(x, y, new Tile(glyph, 0xffbbbbbb, 0xff666666, false, true, "statue of " + getForm(String.fromCharCode(glyph)), null));
				}
			}
		}
		
		public function getForm(c:String):String
		{
			var candidates:Array = forms.filter(function (value:String, index:int, arr:Array):Boolean {
				return value.charAt(0) == c;
			});
			
			if (candidates.length == 0)
				return c;
				
			var candidate:String = candidates[Math.floor(Math.random() * candidates.length)];
			
			if ("aeio".indexOf(candidate.charAt(0)) > -1)
				candidate = "an " + candidate;
			else
				candidate = "a " + candidate;
				
			return candidate;
		}
	}
}