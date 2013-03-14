package spells
{
	import org.microrl.architecture.RL;
	import targeting.ChooseAVisibleEmptyTile;
	import delivery.Composite;
	import delivery.Instant;
	import delivery.Explosion;
	import effect.Fire;
	import effect.Teleport;
	import targeting.Targeting;
	
	public class FieryTeleport implements Magic
	{
		public function get name():String { return "Fire jump"; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return targetWith(caster).calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			targetWith(creature).playerCast(creature);
		}
		
		private function targetWith(creature:Creature):Targeting
		{
			return new ChooseAVisibleEmptyTile(8, 12,  
				function (world:World, x:int, y:int):Composite {
					return new Composite([
						new Instant(world, x, y, new Teleport(creature)),
						new Explosion(world, x, y, 50, new Fire()),
					]);
				});
		}
	}
}