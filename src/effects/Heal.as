package effects 
{
	public class Heal implements Effect
	{
		public var amount:int;
		
		public function Heal(amount:int)
		{
			this.amount = amount;
		}
		
		public function get primaryColor():int { return Color.hsv(210, 66, 77); }
		
		public function get secondaryColor():int { return Color.hsv(210, 66, 66); }
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.hp = Math.min(creature.hp + amount, 100);
			}
		}
		
		public function applySecondary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.hp = Math.min(creature.hp + amount / 2, 100);
			}
		}
	}
}