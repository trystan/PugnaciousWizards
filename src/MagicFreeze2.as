package  
{
	import delivery.Explosion;
	import effect.Ice;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	import targeting.ChooseAVisibleTile;
	
	public class MagicFreeze2 implements Magic
	{	
		private var action:ChooseAVisibleTile = new ChooseAVisibleTile(4, 12, 
			function (world:World, x:int, y:int):Explosion {
				return new Explosion(world, x, y, 49, new Ice());
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