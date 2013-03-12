package  
{
	public class RoomTheme_Bones implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;	
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				if (Math.random() < 0.33)
					continue;
				
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				world.addItem(new PileOfBones(x, y, false));
			}
		}
	}
}