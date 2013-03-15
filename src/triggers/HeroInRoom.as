package triggers 
{
	public class HeroInRoom implements Trigger
	{
		public var room:Room;
		
		public function HeroInRoom(room:Room)
		{
			this.room = room;
		}
		
		public function check(world:World):Boolean
		{			
			var x0:int = room.x * 8 + 5;
			var y0:int = room.y * 8 + 5;
			var x1:int = room.x * 8 + 5 + 7;
			var y1:int = room.y * 8 + 5 + 7;
			
			return world.hero.x >= x0 && world.hero.x <= x1 && world.hero.y >= y0 && world.hero.y <= y1;
		}
	}
}