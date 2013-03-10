package  
{
	import flash.geom.Point;
	public class FieldOfView 
	{
		public var lastVisible:Array;
		public var lastTurn:int = 0;
		
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
			return lastVisible[x][y] == lastTurn;
		}
		
		public function wasVisible(x:int, y:int):Boolean
		{
			return lastVisible[x][y] != -1 && lastVisible[x][y] < lastTurn;
		}
		
		public function getVisibility(x:int, y:int):int
		{
			return lastVisible[x][y];
		}
		
		public function calculateVisibility(x:int, y:int, r:int, isVisible:Function):void
		{
			lastTurn++;
			
			for (var vx:int = x - r; vx < x + r; vx++)
			for (var vy:int = y - r; vy < y + r; vy++)
			{
				if (vx < 0 || vx > 79 || vy < 0 || vy > 79)
					continue;
					
				for each (var p:Point in Line.betweenCoordinates(x, y, vx, vy).points)
				{
					lastVisible[p.x][p.y] = lastTurn;
					
					if (!isVisible(p.x, p.y))
						break;	
				}	
			}
		}
	}
}