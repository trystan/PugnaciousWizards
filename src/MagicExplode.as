package  
{
	import delivery.Explosion;
	import effect.Fire;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	import targeting.ChooseAVisibleTile;
	
	public class MagicExplode implements Magic
	{
		private var action:ChooseAVisibleTile = new ChooseAVisibleTile(8, 12, 
			function (world:World, x:int, y:int):Explosion {
				return new Explosion(world, x, y, 100, new Fire());
			});
			
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return action.calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			return action.playerCast(creature);
		}
	}
}