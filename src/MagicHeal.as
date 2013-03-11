package  
{
	public class MagicHeal implements Magic
	{
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(100 - caster.hp, function(c:Creature):void {
				playerCast(caster);
				trace("hero healed");
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			creature.hp = Math.min(100, creature.hp + 10);
		}
	}
}