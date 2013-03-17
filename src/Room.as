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
		
		public function addDecor(world:World):void
		{
			var wx:int = x * 8 + 4;
			var wy:int = y * 8 + 4;
			
			if (Math.random() < 0.125)
			{
				world.setTile(wx + 1, wy + 1, Tile.wall);
				world.setTile(wx + 7, wy + 1, Tile.wall);
				world.setTile(wx + 7, wy + 7, Tile.wall);
				world.setTile(wx + 1, wy + 7, Tile.wall);
				
				if (Math.random() < 0.125)
				{
					world.setTile(wx + 2, wy + 1, Tile.wall);
					world.setTile(wx + 1, wy + 2, Tile.wall);
					world.setTile(wx + 6, wy + 1, Tile.wall);
					world.setTile(wx + 7, wy + 2, Tile.wall);
					world.setTile(wx + 6, wy + 7, Tile.wall);
					world.setTile(wx + 7, wy + 6, Tile.wall);
					world.setTile(wx + 2, wy + 7, Tile.wall);
					world.setTile(wx + 1, wy + 6, Tile.wall);
				}
			}
		}
		
		public function addPillar(world:World):void
		{
			var px:int = x * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			var py:int = y * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			
			world.setTile(px, py, Tile.wall);
			
			if (Math.random() < 0.2)
				addPillar(world);
		}
		
		public function addBlood(world:World, amount:int):void
		{
			var max:int = world.maxBloodPerTile * 49;
			var total:int = max * amount / 100.0;
			for (var i:int = 0; i < total; i++)
			{
				var bx:int = x * 8 + 4 + Math.floor(Math.random() * 9);
				var by:int = y * 8 + 4 + Math.floor(Math.random() * 9);
				
				world.addBlood(bx, by);
			}
		}
	}
}