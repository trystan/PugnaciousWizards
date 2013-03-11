package  
{
	import org.microrl.architecture.RL;
	
	public class MagicExplode implements Magic
	{
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(0, function(c:Creature):void {
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			RL.enterScreen(new TargetVisibleTileScreen(creature.x, creature.y, creature.viewDistance, creature.world, function(x:int, y:int):void {
				creature.world.addAnimation(new ExplodeAnimation(creature.world, x, y, 100));
			}));
		}
	}
}