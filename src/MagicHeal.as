package  
{
	public class MagicHeal 
	{
		public function apply(creature:Creature):void
		{
			creature.hp = Math.min(100, creature.hp + 10);
		}
	}
}