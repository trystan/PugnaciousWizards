package  
{
	public class RoomTheme_Amulet implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Amulet room";
			room.description = "An piece of an amulet shines brightly in the center of the room.";
			
			var x:int = room.x * 8 + 5 + 3;
			var y:int = room.y * 8 + 5 + 3;
			world.addItem(new PieceOfAmulet(x, y));
			
			x = room.x * 8 + 5 + Math.random() * 5 + 1;
			y = room.y * 8 + 5 + Math.random() * 5 + 1;
			world.addCreature(new Wizard(x, y));
		}
	}
}