package spells
{
	import delivery.Composite;
	import delivery.Explosion;
	import delivery.Ray;
	import delivery.Pull;
	import effects.Ice;
	import effects.MagicDamage;
	import flash.events.KeyboardEvent;
	import org.microrl.architecture.RL;
	import targeting.ChooseDirectionToEnemy;
	
	public class PullAndFreeze implements Magic
	{
		public function get name():String { return "Pull and freeze"; }
		
		public function get description():String { return "Shoot a projectile that pulls creatures together and freezes them."; }
		
		private var action:ChooseDirectionToEnemy = new ChooseDirectionToEnemy(4, 12, 
			function (world:World, x:int, y:int, ox:int, oy:int):Animation {
				return new Ray(world, x, y, ox, oy, 16, new Ice(), function(w:World, px:int, py:int):void {
					world.addAnimation(new Pull(w, px, py, 5, new Ice()));
				})
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