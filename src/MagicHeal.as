package  
{
	public class MagicHeal implements Magic
	{
		public function playerCast(creature:Creature):void
		{
			creature.hp = Math.min(100, creature.hp + 10);
		}
	}
}