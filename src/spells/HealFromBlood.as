package spells
{
	import delivery.EverythingVisible;
	import effects.BloodToHealth;
	import targeting.Self;
	
	public class HealFromBlood implements Magic
	{
		public function get name():String { return "Heal from blood"; }
		
		public function get description():String { return "Recover health based on the amount of blood you see around you."; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return targetWith(caster).calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			targetWith(creature).playerCast(creature);
		}
		
		private function targetWith(creature:Creature):Self
		{
			return new Self(function (world:World, x:int, y:int):EverythingVisible {
					return new EverythingVisible(creature, new BloodToHealth(creature));
				});
		}
	}
}