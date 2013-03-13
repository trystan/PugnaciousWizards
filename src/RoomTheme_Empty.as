package  
{
	public class RoomTheme_Empty implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
		}
	}
}