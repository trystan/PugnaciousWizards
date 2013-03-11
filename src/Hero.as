package  
{
	import flash.geom.Point;
	
	public class Hero extends Player
	{
		public function Hero(x:int, y:int)
		{
			super(x, y);
			
			meleeAttack = 20;
			meleeDefence = 5;
			hp = 200;
		}
		
		override public function updateInternal():void
		{
			for each (var m:Magic in this.magic)
			{
				var potential:MagicAction = m.calculateAiBenefit(this);
				if (Math.random() * 100 < potential.benefit)
				{
					potential.action(this);
					return;
				}
			}
			
			for (var ox:int = -1; ox < 2; ox++)
			for (var oy:int = -1; oy < 2; oy++)
			{
				var other:Creature = world.getCreature(x + ox, y + oy);
				
				if (other != null && other.glyph != "@")
				{
					walk(other.x - x, other.y - y);
					return;
				}
			}
			
			var itemHere:Item = world.getItem(x, y);
			
			if (itemHere is PieceOfAmulet)
			{
				piecesOfAmulet++;
				world.removeItem(itemHere);
			}
			else if (piecesOfAmulet == 3)
			{
				exitCastle();
			}
			else
			{	
				var nextStep:Point = findNearestAmuletPiece();
				
				if (nextStep == null)
					nextStep = findNearestDoor();
				
				if (nextStep == null)
					wander();
				else
					walk(nextStep.x - x, nextStep.y - y);
			}
		}
		
		public function exitCastle():void 
		{
			if (pathToTarget == null
				|| pathToTarget.length == 0
				|| pathToTarget[pathToTarget.length - 1].x != 2 
				|| pathToTarget[pathToTarget.length - 1].y != 40)
			{
				pathToTarget = AStar.pathTo(
					function(px:int, py:int):Boolean { return world.getTile(px, py).isWalkable && world.getTile(px, py) != Tile.closedDoor; }, 
					new Point(x, y),
					new Point(2, 40),
					true);
			}

			if (pathToTarget != null && pathToTarget.length > 0)
			{
				var nextStep:Point = pathToTarget.shift();
				walk(nextStep.x - x, nextStep.y - y);
			}
		}
		
		private var pathToTarget:Array = null;
		public function findNearestAmuletPiece():Point
		{
			if (pathToTarget != null && pathToTarget.length > 0)
			{
				var last:Point = pathToTarget[pathToTarget.length - 1];
				var itemAtTarget:Item = world.getItem(last.x, last.y);
				
				if (itemAtTarget is PieceOfAmulet)
					return pathToTarget.shift();
			}
			
			for each (var item:Item in world.items)
			{
				if (!(item is PieceOfAmulet))
					continue;
				
				var path:Array = Line.betweenCoordinates(x, y, item.x, item.y).points;
				var failed:Boolean = false;
				for each (var point:Point in path)
				{
					if (!world.getTile(point.x, point.y).isWalkable)
						failed = true;
				}
				
				if (failed)
					continue;
					
				pathToTarget = path;
				return pathToTarget.shift();
			}
		
			return null;
		}
		
		public function findNearestDoor():Point
		{
			if (pathToTarget == null || pathToTarget.length == 0)
			{
				pathToTarget = Dijkstra.pathTo(
					new Point(x, y), 
					function(px:int,py:int):Boolean { return world.getTile(px, py).isWalkable; },
					function(px:int,py:int):Boolean { return world.getTile(px, py) == Tile.closedDoor; } );
			}
			
			if (pathToTarget == null || pathToTarget.length == 0)
				return null;
				
			return pathToTarget.shift();
		}
	}
}