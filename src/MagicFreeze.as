package  
{
	import org.microrl.architecture.RL;
	
	public class MagicFreeze 
	{	
		public function apply(creature:Creature):void
		{
			RL.enterScreen(new TargetDirectionScreen(function(mx:int, my:int):void {
				creature.world.addAnimation(new FreezeAnimation(creature.world, creature.x, creature.y, mx, my));
			}));
		}
	}
}