package  
{
	public class RoomTheme_Bloody implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Bloody room";
			room.description = "Blood covers the floors and walls of this room. The humid air reeks. Bad things have happened in here before....";
			
			var max:int = world.maxBloodPerTile * 49;
			var total:int = (Math.random() * max + Math.random() * max) / 4;
			for (var i:int = 0; i < total; i++)
			{
				var x:int = room.x * 8 + 4 + Math.floor(Math.random() * 9);
				var y:int = room.y * 8 + 4 + Math.floor(Math.random() * 9);
				
				world.addBlood(x, y);
			}
		}
	}
}