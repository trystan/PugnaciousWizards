package spells
{
	import delivery.Composite;
	import delivery.Instant;
	import targeting.Self;
	import effects.*;
	
	public class HealAndBlind implements Magic
	{
		public function get name():String { return "Heal and weaken"; }
		
		public function get description():String { return "Fully heals yourself but slightly reduces your vision and maximum health."; }
		
		private var action:Self = new Self(
			function (world:World, x:int, y:int):Animation {
				return new Composite([
							new Instant(world, x, y, new ReduceMaximumHealth()),
							new Instant(world, x, y, new ReduceVision()),
							new Instant(world, x, y, new Heal(100))]);
			});
			
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var damage:int = caster.hp > 75 ? 0 : (1 - (caster.hp * 1.0 / caster.maximumHp)) * 50;
			
			return new MagicAction(damage, function():void {
				return caster.world.addAnimation(new Composite([
							new Instant(caster.world, caster.x, caster.y, new ReduceMaximumHealth()),
							new Instant(caster.world, caster.x, caster.y, new ReduceVision()),
							new Instant(caster.world, caster.x, caster.y, new Heal(100))]));
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			action.playerCast(creature);
		}
	}
}