package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	import org.microrl.architecture.Screen;
	public class World 
	{
		private var tiles:Array;
		
		public var hero:Creature;
		
		public var creatures:Array = [];
		public var creatureGrid:Array = [];
		public var items:Array = [];
		public var animations:Array = [];
		public var rooms:Array = [];
		public var blood:Array = [];
		public var burningTiles:Array = [];
		
		public var maxBloodPerTile:int = 15;
		public var perlinBitmap:BitmapData;
		public var triggers:Array = [];
		
		public var treeType:int;
		
		public function World()
		{	
			perlinBitmap = new BitmapData(80, 80, false, 0x00CCCCCC);
			var randomNum:Number = Math.floor(Math.random() * 10);
			perlinBitmap.perlinNoise(6, 6, 6, randomNum, false, true, 1, true, null);

			treeType = Math.floor(Math.random() * 3);
			
			makeCastleWalls();
			makeMaze();
			addRandomDoors();
			setTile(4, 40, Tile.closedDoor);
			
			addRoom(new Room(0, 4, 0));
			
			creatureGrid = [];
			for (var x:int = 0; x < 80; x++)
			{
				var row:Array = [];
				for (var y:int = 0; y < 80; y++)
					row.push(null);
				creatureGrid.push(row);
			}
			
			blood = [];
			for (var x:int = 0; x < 80; x++)
			{
				var row:Array = [];
				for (var y:int = 0; y < 80; y++)
					row.push(0);
				blood.push(row);
			}
			addBloodStains();
		}
		
		private function addBloodStains():void 
		{
			for (var i:int = 0; i < 250; i++)
			{
				var x:int = Math.floor(Math.random() * 8 * 9) + 5;
				var y:int = Math.floor(Math.random() * 8 * 9) + 5;
				
				addBlood(x, y);
			}
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
			updateBurningStuff();
				
 			for each (var item:Item in items)
				item.update();
				
			for each (var creature:Creature in creatures)
				creature.update();
			
			
			for each (var trigger:Function in triggers)
				trigger();
			
			var alive:Array = [];
			for each (creature in creatures)
			{
				if (creature.hp > 0)
					alive.push(creature);
				else
				{
					addItem(new PileOfBones(creature.x, creature.y));
					creatureGrid[creature.x][creature.y] = null;
				}
			}
			creatures = alive;
		}
		
		public function getTile(x:int, y:int):Tile
		{
			if (x < 0 || y < 0 || x > 79 || y > 79)
				return Tile.outOfBounds;
				
			return tiles[x][y];
		}
		
		public function addTriggerForEveryTurn(trigger:Function):void
		{
			triggers.push(trigger);
		}
		
		public function addAnimation(animation:Animation):void
		{
			RL.instance.addAnimation(animation);
		}
		
		public function setTile(x:int, y:int, t:Tile):void
		{
			if (t == Tile.portal)
			{
				t = new Tile(t.glyph.charCodeAt(0), t.fg, t.bg, t.isWalkable, t.allowsVision, t.name, t.description);
				t.isPortal = true;
				t.fg = Color.hsv(Math.floor(Math.random() * 360), 25, 95);
				t.bg = Color.hsv(Math.floor(Math.random() * 360), 25, 95);
			}
			else if (t == Tile.grass)
			{
				t = new Tile(t.glyph.charCodeAt(0), t.fg, t.bg, t.isWalkable, t.allowsVision, t.name, t.description);
				t.bg = Color.hsv(100, 20, 15 + Math.floor((perlinBitmap.getPixel(x, y) & 0xFF) / 255.0 * 10));
			}
			else if (t == Tile.tree)
			{
				t = new Tile(t.glyph.charCodeAt(0), t.fg, t.bg, t.isWalkable, t.allowsVision, t.name, t.description);
				
				switch (treeType)
				{
					case 0: t.glyph = String.fromCharCode(5); break;
					case 1: t.glyph = String.fromCharCode(6); break;
					case 2: t.glyph = String.fromCharCode(30); break;
				}
				
				t.fg = Color.hsv(100 + Math.random() * 40, 50 + Math.random() * 30, 30 + Math.random() * 30);
				t.bg = Color.hsv(120, 20, 15 + Math.floor((perlinBitmap.getPixel(x, y) & 0xFF) / 255.0 * 10));
			}
			
			tiles[x][y] = t;
			
			if (t == Tile.burningDoor10 || t == Tile.burningTree3)
			{
				burningTiles.push(new Point(x, y));
			}
		}
		
		public function addCreature(creature:Creature):void
		{
			creatures.push(creature);
			creatureGrid[creature.x][creature.y] = creature;
			creature.world = this;
		}
		
		public function addItem(item:Item):void
		{
			items.push(item);
			item.world = this;
		}
		
		public function removeItem(item:Item):void
		{
			items = items.filter(function(value:Item, index:int, array:Array):Boolean {
				return value != item;
			});
		}
		
		public function getRoom(x:int, y:int):Room
		{	
			for each (var room:Room in rooms)
			{
				if (room.x * 8 + 4 < x && room.x * 8 + 12 > x 
				 && room.y * 8 + 4 < y && room.y * 8 + 12 > y)
					return room;
			}
			return null;
		}
		
		public function getItem(x:int, y:int):Item
		{
			for each (var item:Item in items)
			{
				if (item.x == x && item.y == y)
					return item;
			}
			return null;
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
			setTile(0, 10, Tile.tree);
			setTile(2, 10, Tile.tree);
			setTile(2, 11, Tile.tree);
			setTile(3, 10, Tile.tree);
			setTile(3, 11, Tile.tree);
			setTile(3, 12, Tile.tree);
			
			setTile(6, 3, Tile.tree);
			
			setTile(0, 69, Tile.tree);
			setTile(0, 70, Tile.tree);
			setTile(3, 70, Tile.tree);
			
			setTile(6, 77, Tile.tree);
			setTile(7, 77, Tile.tree);
			setTile(6, 78, Tile.tree);
			
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
			
			ApplyNaturalVariation();
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
			if (x < 0 || y < 0 || x > 79 || y > 79)
				return null;
				
			return creatureGrid[x][y];
			/*
			for each (var creature:Creature in creatures)
			{
				if (creature.hp > 0 && creature.x == x && creature.y == y)
					return creature;
			}
			return null;*/
		}
		
		public function getBlood(x:int, y:int):int 
		{
			if (tiles[x][y].isPortal || tiles[x][y] == Tile.pit)
				return 0;
			else
				return blood[x][y];
		}
		
		public function addBlood(x:int, y:int):void
		{
			addBloodOnce(x, y);
			
			if (Math.random() < 0.15)
				addBloodOnce(x-1, y);
			if (Math.random() < 0.15)
				addBloodOnce(x+1, y);
			if (Math.random() < 0.15)
				addBloodOnce(x, y-1);
			if (Math.random() < 0.15)
				addBloodOnce(x, y+1);
			if (Math.random() < 0.075)
				addBloodOnce(x-1, y-1);
			if (Math.random() < 0.075)
				addBloodOnce(x+1, y-1);
			if (Math.random() < 0.075)
				addBloodOnce(x-1, y+1);
			if (Math.random() < 0.075)
				addBloodOnce(x+1, y+1);
		}
		
		public function move(creature:Creature, x:int, y:int, nx:int, ny:int):void 
		{
			if (x < 0 && y < 0) // removed from game
				;
			else if (creatureGrid[x][y] != creature)
				trace(creature.name + " isn't where it should be!");
			else
				creatureGrid[x][y] = null;
		
			if (!(nx < 0 && ny < 0)) // removing from game
				creatureGrid[nx][ny] = creature;
		}
		
		public function removeBlood(x:int, y:int):void 
		{
			blood[x][y] = 0;
		}
		
		private function addBloodOnce(x:int, y:int):void
		{
			if (x < 0 || y < 0 || x > 79 || y > 79)
				return;
				
			blood[x][y] = Math.min(blood[x][y] + 1, maxBloodPerTile);
		}
		
		private function updateBurningStuff():void 
		{
			var stillBurning:Array = [];
			for each (var p:Point in burningTiles)
			{
				var keepBurning:Boolean = true;
				
				switch (getTile(p.x, p.y))
				{
				case Tile.burningDoor10: setTile(p.x, p.y, Tile.burningDoor9); break;
				case Tile.burningDoor9: setTile(p.x, p.y, Tile.burningDoor8); break;
				case Tile.burningDoor8: setTile(p.x, p.y, Tile.burningDoor7); break;
				case Tile.burningDoor7: setTile(p.x, p.y, Tile.burningDoor6); break;
				case Tile.burningDoor6: setTile(p.x, p.y, Tile.burningDoor5); break;
				case Tile.burningDoor5: setTile(p.x, p.y, Tile.burningDoor4); break;
				case Tile.burningDoor4: setTile(p.x, p.y, Tile.burningDoor3); break;
				case Tile.burningDoor3: setTile(p.x, p.y, Tile.burningDoor2); break;
				case Tile.burningDoor2: setTile(p.x, p.y, Tile.burningDoor1); break;
				case Tile.burningDoor1: 
					setTile(p.x, p.y, Tile.burntFloor);
					keepBurning = false;
					break;
				case Tile.burningTree3: 
					if (Math.random() < 0.3)
						setTile(p.x, p.y, Tile.burningTree2);
					break;
				case Tile.burningTree2: 
					if (Math.random() < 0.2)
						setTile(p.x, p.y, Tile.burningTree1);
					break;
				case Tile.burningTree1: 
					if (Math.random() < 0.1)
					{
						setTile(p.x, p.y, Tile.burntFloor);
						keepBurning = false;
					}
					break;
				}
				
				if (keepBurning)
					stillBurning.push(p);
			}
			
			burningTiles = stillBurning;
			
			for each (var p:Point in burningTiles)
			{
				for each (var offset:Array in [[-1,0],[1,0],[0,-1],[0,1]])
				{
					var c:Creature = getCreature(p.x + offset[0], p.y + offset[1]);
					if (c != null)
						c.isOnFireCounter += 3;
						
					var here:Tile = getTile(p.x + offset[0], p.y + offset[1]);
					if (here.isTree
						&& here != Tile.burningTree3
						&& here != Tile.burningTree2
						&& here != Tile.burningTree1
						&& Math.random() < 0.05)
					{
						setTile(p.x + offset[0], p.y + offset[1], Tile.burningTree3);
					}
				}
			}
		}
		
		private function ApplyNaturalVariation():void 
		{
			for (var x:int = 0; x < 80; x++)
			for (var y:int = 0; y < 80; y++)
			{
				if (getTile(x, y) == Tile.grass)
					setTile(x, y, Tile.grass);
				else if (getTile(x, y) == Tile.tree)
					setTile(x, y, Tile.tree);
			}
		}
	}
}