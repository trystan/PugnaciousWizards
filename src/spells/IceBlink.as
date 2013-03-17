package spells
{
	import delivery.RandomVisibleSpace;
	import effects.Disapear;
	import org.microrl.architecture.RL;
	import targeting.Self;
	import delivery.Composite;
	import delivery.Instant;
	import delivery.Explosion;
	import effects.Ice;
	import effects.Teleport;
	import targeting.Targeting;
	
	public class IceBlink implements Magic
	{
		public function get name():String { return "Ice blink"; }
		
		public function get description():String { return "Freeze the area round you then teleport to a random nearby location."; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			var count:int = 0
			for each (var dir:Array in dirs)
			{
				if (caster.world.getCreature(caster.x + dir[0], caster.y + dir[1]) != null)
					count++;
			}
			
			return new MagicAction(count * 10, function(c:Creature):void {
				caster.world.addAnimation(new Composite([
						new Instant(caster.world, caster.x, caster.y, new Disapear(caster)),
						new Explosion(caster.world, caster.x, caster.y, 25, new Ice()),
						new RandomVisibleSpace(caster, new Teleport(caster)),
					]));
			} );
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