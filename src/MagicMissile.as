package  
{
	import org.microrl.architecture.RL;
	
	public class MagicMissile 
	{
		public function apply(creature:Creature):void
		{
			RL.enterScreen(new TargetDirectionScreen(function(mx:int, my:int):void {
				creature.world.addAnimation(new ArrowAnimation(creature.world, creature.x, creature.y, mx, my));
			}));
		}
	}
}