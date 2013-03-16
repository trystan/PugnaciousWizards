package effects 
{
	public class Fire implements Effect
	{
		public function get primaryColor():int { return Color.fire; }
		
		public function get secondaryColor():int { return Color.fire; }
		
		public var amount:int;
		public function Fire(amount:int)
		{
			this.amount = amount;
		}
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.hp -= amount;
				creature.isOnFireCounter += amount;
			}
			var here:Tile = world.getTile(x, y);
			if (here == Tile.closedDoor || here == Tile.openDoor)
			{
				world.setTile(x, y, Tile.burningDoor10);
			}
			else if (here.isTree
			  && here != Tile.burningTree3
			  && here != Tile.burningTree2
			  && here != Tile.burningTree1)
			{
				world.setTile(x, y, Tile.burningTree3);
			}
		}
		
		public function applySecondary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.hp -= amount / 5;
				creature.isOnFireCounter += amount / 5;
			}
		}
	}
}