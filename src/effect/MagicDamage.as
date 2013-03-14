package effect 
{
	public class MagicDamage implements Effect
	{
		public var amount:int;
		
		public function MagicDamage(amount:int)
		{
			this.amount = amount;
		}
		
		public function get primaryColor():int { return Color.hsv(240, 66, 99); }
		
		public function get secondaryColor():int { return Color.hsv(240, 66, 88); }
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.hp -= amount;
			}
		}
		
		public function applySecondary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				creature.hp -= amount / 2;
			}
		}
	}
}