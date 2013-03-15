package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Effect;
	import flash.geom.Point;
	
	public class RandomVisibleSpace implements Animation 
	{
		public var world:World;
		public var fov:FieldOfView;
		public var magicEffect:Effect;
		
		public function RandomVisibleSpace(creature:Creature, magicEffect:Effect) 
		{
			this.world = creature.world;
			this.fov = new FieldOfView();
			this.magicEffect = magicEffect;
			
			fov.calculateVisibility(creature.x, creature.y, 13, function(vx:int, vy:int):Boolean {
				return creature.world.getTile(vx, vy).allowsVision;
			});
		}
		
		public function get isDone():Boolean 
		{
			return true;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			var candidates:Array = fov.currentlyVisiblePoints.filter(function (value:Point, index:int, arr:Array):Boolean {
				return world.getTile(value.x, value.y).isWalkable;
			});
			
			if (candidates.length == 0)
				return;
			
			var point:Point = candidates[Math.floor(Math.random() * candidates.length)];
			magicEffect.applyPrimary(world, point.x, point.y);
		}
	}
}