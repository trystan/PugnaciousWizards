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
			
			if (Math.random() < 0.75)
				addPillar(world, room);
		}
		
		public function addPillar(world:World, room:Room):void
		{
			var x:int = room.x * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			var y:int = room.y * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			
			world.setTile(x, y, Tile.wall);
			
			if (Math.random() < 0.2)
				addPillar(world, room);
		}
	}
}