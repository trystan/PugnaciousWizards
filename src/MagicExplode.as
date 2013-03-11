package  
{
	import org.microrl.architecture.RL;
	
	public class MagicExplode 
	{
		private var fov:FieldOfView;
		
		public function MagicExplode(fov:FieldOfView)
		{
			this.fov = fov;
		}
		
		public function apply(creature:Creature):void
		{
			RL.enterScreen(new TargetVisibleTileScreen(creature.x, creature.y, fov, function(x:int, y:int):void {
				creature.world.addAnimation(new ExplodeAnimation(creature.world, x, y, 100));
			}));
		}
	}
}