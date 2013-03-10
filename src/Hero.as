package  
{
	import flash.geom.Point;
	
	public class Hero extends Creature
	{
		public function Hero(x:int, y:int)
		{
			super("@", Color.hsv(0, 0, 90), x, y);
			
			meleeAttack = 20;
			meleeDefence = 5;
			hp = 100;
		}
		
		override public function update():void
		{
			for (var ox:int = -1; ox < 2; ox++)
			for (var oy:int = -1; oy < 2; oy++)
			{
				var other:Creature = world.getCreature(x + ox, y + oy);
				
				if (other != null && other.glyph != "@" && other.glyph != "k")
				{
					walk(other.x - x, other.y - y);
					return;
				}
			}
			
			var nextStep:Point = findNearestDoor();
			
			if (nextStep == null)
				wander();
			else
				walk(nextStep.x - x, nextStep.y - y);
		}
		
		private var pathToDoor:Array = null;
		public function findNearestDoor():Point
		{
			if (pathToDoor == null || pathToDoor.length == 0)
			{
				pathToDoor = Dijkstra.pathTo(
					new Point(x, y), 
					function(px:int,py:int):Boolean { return world.getTile(px, py).isWalkable; },
					function(px:int,py:int):Boolean { return world.getTile(px, py) == Tile.closedDoor; } );
			}
			
			if (pathToDoor == null || pathToDoor.length == 0)
				return null;
				
			return pathToDoor.shift();
		}
	}
}