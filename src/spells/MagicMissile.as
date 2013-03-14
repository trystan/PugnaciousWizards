package spells
{
	import delivery.MagicMissileProjectile;
	import effect.MagicDamage;
	import flash.events.KeyboardEvent;
	import org.microrl.architecture.RL;
	import targeting.ChooseDirectionToEnemy;
	
	public class MagicMissile implements Magic
	{
		public function get name():String { return "Magic Missile"; }
		
		private var action:ChooseDirectionToEnemy = new ChooseDirectionToEnemy(4, 12, 
			function (world:World, x:int, y:int, ox:int, oy:int):AnimatedScreen {
				return new MagicMissileProjectile(world, x, y, ox, oy, 16, new MagicDamage(11))
			});
			
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return action.calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			action.playerCast(creature);
		}
	}
}