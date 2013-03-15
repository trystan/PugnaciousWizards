package effects 
{
	public class Blind implements Effect
	{
		public function get primaryColor():int { return 0xffffffff; }
		
		public function get secondaryColor():int { return 0xffeeeeee; }
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null && creature.isBlindCounter == 0)
			{
				creature.isBlindCounter += 5;
			}
		}
		
		public function applySecondary(world:World, x:int, y:int):void
		{
		}
	}
}