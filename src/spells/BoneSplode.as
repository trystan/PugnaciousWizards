package spells
{
	import delivery.ExplodeEveryVisiblePileOfBones;
	import targeting.Self;
	import effects.MagicDamage;
	
	public class BoneSplode implements Magic
	{
		public function get name():String { return "Bone-splode"; }
		
		public function get description():String { return "Any piles of bones that you see explode - which is very bad for anyone near them."; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(1, function(c:Creature):void { } );
				
			return targetWith(caster).calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			targetWith(creature).playerCast(creature);
		}
		
		private function targetWith(creature:Creature):Self
		{
			return new Self(function (world:World, x:int, y:int):ExplodeEveryVisiblePileOfBones {
					return new ExplodeEveryVisiblePileOfBones(creature, new MagicDamage(15));
				});
		}
	}
}