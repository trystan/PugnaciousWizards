package  
{
	import effect.Ice;
	import delivery.Ray;
	import flash.events.KeyboardEvent;
	import org.microrl.architecture.RL;
	import targeting.ChooseDirectionToEnemy;
	
	public class MagicFreeze implements Magic
	{	
		public function get name():String { return "Freeze"; }
		
		private var action:ChooseDirectionToEnemy = new ChooseDirectionToEnemy(4, 12, 
			function (world:World, x:int, y:int, ox:int, oy:int):Animation {
				return new Ray(world, x, y, ox, oy, 16, new Ice())
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