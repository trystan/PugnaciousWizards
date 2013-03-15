package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	
	public class EverythingVisible implements Animation
	{
		public var world:World;
		public var fov:FieldOfView;
		public var magicEffect:Effect;
		
		public function EverythingVisible(creature:Creature, magicEffect:Effect) 
		{
			this.world = creature.world;
			this.fov = new FieldOfView();
			this.magicEffect = magicEffect;
			
			fov.calculateVisibility(creature.x, creature.y, creature.viewDistance - 1, function(vx:int, vy:int):Boolean {
				return creature.world.getTile(vx, vy).allowsVision;
			});
		}
		
		public function get isDone():Boolean 
		{
			return true;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			for (var x:int = 0; x < 80; x++)
			for (var y:int = 0; y < 80; y++)
			{
				if (!fov.isVisibleNow(x, y))
					continue;
				
				if (world.hero.canSeeLocation(x, y))
					terminal.write(" ", x, y, magicEffect.primaryColor, magicEffect.secondaryColor);
				
				magicEffect.applyPrimary(world, x, y);
			}
		}
	}
}