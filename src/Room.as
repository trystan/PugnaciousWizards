package  
{
	public class Room 
	{
		public var x:int;
		public var y:int;
		public var dist:int;
		public var hasTheme:Boolean = false;
		public var forbidMagic:Boolean = false;
		public var name:String = "";
		public var description:String = null;
		
		public function Room(x:int, y:int, dist:int) 
		{
			this.x = x;
			this.y = y;
			this.dist = dist;
		}
		
		public function contains(creature:Creature):Boolean
		{
			var mapX:int = x * 8 + 4;
			var mapY:int = y * 8 + 4;
			
			return creature.x >= mapX && creature.x < mapX + 8 && creature.y >= mapY && creature.y < mapY + 8;
		}
	}
}