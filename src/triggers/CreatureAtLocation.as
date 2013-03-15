package triggers 
{
	import flash.geom.Point;
	
	public class CreatureAtLocation implements Trigger
	{
		public var room:Room;
		public var points:Array;
		
		public function CreatureAtLocation(room:Room, points:Array)
		{
			this.room = room;
			this.points = points;
		}
		
		public function check(world:World):Boolean
		{
			if (!room.contains(world.hero))
				return false;
					
			for each (var p:Point in points)
			{
				if (world.getCreature(p.x, p.y) != null)
					return true;
			}
			return false;
		}
	}
}