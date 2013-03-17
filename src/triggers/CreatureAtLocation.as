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
				var creature:Creature = world.getCreature(p.x, p.y);
				if (creature != null)
				{
					world.setTile(p.x, p.y, Tile.exposedTrap);
					HelpSystem.notify(creature, "Floor traps", Tile.exposedTrap.glyph, 
						"Some rooms have hidden traps in the floors; it looks like you found one. They're usually laid out in some pattern. If you know the pattern then you can avoid them. Or lure others into them....");
					return true;
				}
			}
			return false;
		}
	}
}