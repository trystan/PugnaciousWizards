package spells
{
	import targeting.Self;
	import delivery.Explosion;
	import effects.Heal;
	
	public class HealingBurst implements Magic
	{
		public function get name():String { return "Healing burst"; }
		
		public function get description():String { return "Heals yourself. Anyone next to you may also get healed a little."; }
		
		private var action:Self = new Self(
			function (world:World, x:int, y:int):Animation {
				return new Explosion(world, x, y, 9, new Heal(5))
			});
			
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(100 - caster.hp, function():void {
				return caster.world.addAnimation(new Explosion(caster.world, caster.x, caster.y, 9, new Heal(5)));
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			action.playerCast(creature);
		}
	}
}