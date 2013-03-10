package  
{
	import flash.geom.Point;
	public class World 
	{
		private var tiles:Array;
		
		public var creatures:Array = [];
		public var items:Array = [];
		public var animations:Array = [];
		public var rooms:Array = [];
		
		public function World() 
		{
			makeCastleWalls();
			makeMaze();
			addRandomDoors();
			setTile(4, 40, Tile.closedDoor);
			
			addRoom(new Room(0, 4, 0));
		}
		
		private function addRoom(room:Room):void
		{
			var existing:Array = rooms.filter(function (value:Room, index:int, array:Array):Boolean {
				return value.x == room.x && value.y == room.y;
			});
			
			if (existing.length > 0)
			{
				if (room.dist >= existing[0].dist)
					return;
				
				existing[0].dist = room.dist;
			}
			else
			{
				rooms.push(room);
			}
					
			if (room.y > 0 && getTile(room.x * 8 + 4 + 4, room.y * 8 + 4) == Tile.closedDoor)
				addRoom(new Room(room.x, room.y - 1, room.dist + 1));
				
			if (room.y < 8 && getTile(room.x * 8 + 4 + 4, room.y * 8 + 4 + 8) == Tile.closedDoor)
				addRoom(new Room(room.x, room.y + 1, room.dist + 1));
			
			if (room.x > 0 && getTile(room.x * 8 + 4, room.y * 8 + 4 + 4) == Tile.closedDoor)
				addRoom(new Room(room.x - 1, room.y, room.dist + 1));
				
			if (room.x < 8 && getTile(room.x * 8 + 4 + 8, room.y * 8 + 4 + 4) == Tile.closedDoor)
				addRoom(new Room(room.x + 1, room.y, room.dist + 1));
		}
		
		public function update():void
		{
			for each (var item:PileOfBones in items)
				item.update();
				
			for each (var creature:Creature in creatures)
				creature.update();
				
			var alive:Array = [];
			for each (creature in creatures)
			{
				if (creature.hp > 0)
					alive.push(creature);
				else
					addItem(new PileOfBones(creature.x, creature.y));
			}
			creatures = alive;
		}
		
		public function getTile(x:int, y:int):Tile
		{
			if (x < 0 || y < 0 || x > 79 || y > 79)
				return Tile.outOfBounds;
				
			return tiles[x][y];
		}
		
		public function addAnimation(animation:ArrowAnimation):void
		{
			animations.push(animation);
		}
		
		public function setTile(x:int, y:int, t:Tile):void
		{
			tiles[x][y] = t;
		}
		
		public function addCreature(creature:Creature):void
		{
			creatures.push(creature);
			creature.world = this;
		}
		
		public function addItem(item:PileOfBones):void
		{
			items.push(item);
			item.world = this;
		}
		
		public function removeItem(item:PileOfBones):void
		{
			items = items.filter(function(value:PileOfBones, index:int, array:Array):Boolean {
				return value != item;
			});
		}
		
		private function makeCastleWalls():void 
		{
			tiles = [];
			for (var x:int = 0; x < 80; x++)
			{
				var row:Array = [];
				for (var y:int = 0; y < 80; y++)
				{
					if (x < 6 && y < 5)
						row.push(Tile.tree);
					else if (x < 6 && y > 75)
						row.push(Tile.tree);
					else if (x < 4 && (y < 10 || y > 70))
						row.push(Tile.tree);
					else if (x < 4)
						row.push(Tile.grass);
					else if (x < 4 || y < 4 || x > 76 || y > 76)
						row.push(Tile.pit);
					else if ((x + y) % 2 == 0)
						row.push(Tile.tile1);
					else
						row.push(Tile.tile2);
				}
				tiles.push(row);
			}
			tiles[0][10] = Tile.tree;
			tiles[2][10] = Tile.tree;
			tiles[2][11] = Tile.tree;
			tiles[3][10] = Tile.tree;
			tiles[3][11] = Tile.tree;
			tiles[3][12] = Tile.tree;
			
			tiles[6][3] = Tile.tree;
			
			tiles[0][69] = Tile.tree;
			tiles[0][70] = Tile.tree;
			tiles[3][70] = Tile.tree;
			
			tiles[6][77] = Tile.tree;
			tiles[7][77] = Tile.tree;
			tiles[6][78] = Tile.tree;
			
			for (x = 0; x < 10; x++)
			{
				for (y = 0; y < 73; y++)
					setTile(x * 8 + 4, y + 4, Tile.wall);
			}
			
			for (y = 0; y < 10; y++)
			{
				for (x = 0; x < 73; x++)
					setTile(x + 4, y * 8 + 4, Tile.wall);
			}
		}
		
		private function makeMaze():void 
		{
			var cells:Array = [];
			for (var x:int = 0; x < 80; x++)
			{
				var row:Array = [];
				for (var y:int = 0; y < 80; y++)
					row.push(false);
				cells.push(row);
			}
			
			makeMazeStep(cells, new Point(0, 5));
		}
		
		private function makeMazeStep(cells:Array, here:Point):void
		{
			if (cells[here.x][here.y])
				return;
			
			cells[here.x][here.y] = true;
			
			var neighbors:Array = [];
			
			for each (var offsets:Array in [[ -1, 0], [1, 0], [0, -1], [0, 1]])
			{
				var next:Point = new Point(here.x + offsets[0], here.y + offsets[1]);
				
				if (next.x < 0 || next.y < 0 || next.x > 8 || next.y > 8)
					continue;
				
				neighbors.push(next);
			}
			
			while (neighbors.length > 0)
			{
				var nextCell:Point = neighbors[Math.floor(Math.random() * neighbors.length)];
				
				neighbors.splice(neighbors.indexOf(nextCell), 1);
				
				if (cells[nextCell.x][nextCell.y])
					continue;
					
				var doorX:Number = (here.x + nextCell.x) / 2 * 8 + 8;
				var doorY:Number = (here.y + nextCell.y) / 2 * 8 + 8;
				
				setTile(doorX, doorY, Tile.closedDoor);
				
				makeMazeStep(cells, nextCell);
			}
		}
		
		public function addRandomDoors():void
		{
			for (var i:int = 0; i < 20; i++)
			{
				var x:int = Math.floor(Math.random() * 8) * 8 + 8;
				var y:int = Math.floor(Math.random() * 8) * 8 + 8;
				
				if (Math.random() < 0.5)
					x += 4;
				else
					y += 4;
				
				setTile(x, y, Tile.closedDoor);
			}
		}
		
		public function getCreature(x:int, y:int):Creature 
		{
			for each (var creature:Creature in creatures)
			{
				if (creature.hp > 0 && creature.x == x && creature.y == y)
					return creature;
			}
			return null;
		}
	}
}