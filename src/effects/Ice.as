package effects 
{
	public class Ice implements Effect
	{
		public function get primaryColor():int { return Color.ice; }
		
		public function get secondaryColor():int { return Color.ice; }
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.isFrozenCounter += 3;
			}
		}
		
		public function applySecondary(world:World, x:int, y:int):void 
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.isFrozenCounter++;
			}
		}
	}
}