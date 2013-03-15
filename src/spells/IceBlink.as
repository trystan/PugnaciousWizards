package spells
{
	import delivery.RandomVisibleSpace;
	import effect.Disapear;
	import org.microrl.architecture.RL;
	import targeting.Self;
	import delivery.Composite;
	import delivery.Instant;
	import delivery.Explosion;
	import effect.Ice;
	import effect.Teleport;
	import targeting.Targeting;
	
	public class IceBlink implements Magic
	{
		public function get name():String { return "Ice blink"; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(0, function(c:Creature):void { } );
				
			return targetWith(caster).calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			targetWith(creature).playerCast(creature);
		}
		
		private function targetWith(creature:Creature):Targeting
		{
			return new Self(
				function (world:World, x:int, y:int):Composite {
					return new Composite([
						new Instant(world, x, y, new Disapear(creature)),
						new Explosion(world, x, y, 25, new Ice()),
						new RandomVisibleSpace(creature, new Teleport(creature)),
					]);
				});
		}
	}
}