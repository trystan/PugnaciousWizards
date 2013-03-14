package  
{
	import flash.geom.Point;
	public class FieldOfView 
	{
		public var lastVisible:Array;
		public var lastTurn:int = 0;
		public var currentlyVisiblePoints:Array = [];
		
		public function FieldOfView() 
		{
			lastVisible = [];
			for (var x:int = 0; x < 80; x++)
			{
				var row:Array = [];
				for (var y:int = 0; y < 80; y++)
					row.push( -1);
				lastVisible.push(row);
			}
		}
		
		public function isVisibleNow(x:int, y:int):Boolean
		{
			if (x < 0 || x > 79 || y < 0 || y > 79)
				return false;
				
			return lastVisible[x][y] == lastTurn;
		}
		
		public function isUnknown(x:int, y:int):Boolean
		{
			if (x < 0 || x > 79 || y < 0 || y > 79)
				return false;
				
			return lastVisible[x][y] == -1;
		}
		
		public function wasVisible(x:int, y:int):Boolean
		{
			if (x < 0 || x > 79 || y < 0 || y > 79)
				return false;
				
			return lastVisible[x][y] != -1 && lastVisible[x][y] < lastTurn;
		}
		
		public function getVisibility(x:int, y:int):int
		{
			return lastVisible[x][y];
		}
		
		public function calculateVisibility(x:int, y:int, r:int, isVisible:Function):void
		{
			lastTurn++;
			currentlyVisiblePoints = [];
		
			if (x < 0 || x > 79 || y < 0 || y > 79)
				return;
				
			for (var vx:int = x - r; vx < x + r + 1; vx++)
			for (var vy:int = y - r; vy < y + r + 1; vy++)
			{
				if (vx < 0 || vx > 79 || vy < 0 || vy > 79)
					continue;
					
				for each (var p:Point in Line.betweenCoordinates(x, y, vx, vy).points)
				{
					if (lastVisible[p.x][p.y] != lastTurn)
					{
						currentlyVisiblePoints.push(new Point(p.x, p.y));
						lastVisible[p.x][p.y] = lastTurn;
					}
					
					if (!isVisible(p.x, p.y))
						break;
				}	
			}
		}
	}
}