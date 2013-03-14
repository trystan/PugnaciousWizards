package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	import flash.geom.Point;
	
	public class RandomVisibleSpace extends AnimatedScreen 
	{
		public function RandomVisibleSpace(creature:Creature, magicEffect:Effect) 
		{
			var fov:FieldOfView = new FieldOfView();
			
			fov.calculateVisibility(creature.x, creature.y, 13, function(vx:int, vy:int):Boolean {
				return creature.world.getTile(vx, vy).allowsVision;
			});
			
			display(function(terminal:AsciiPanel):void {
				var candidates:Array = fov.currentlyVisiblePoints.filter(function (value:Point, index:int, arr:Array):Boolean {
					return creature.world.getTile(value.x, value.y).isWalkable;
				});
				
				if (candidates.length == 0)
					return;
				
				var point:Point = candidates[Math.floor(Math.random() * candidates.length)];
				magicEffect.applyPrimary(creature.world, point.x, point.y);
			});
			
			bind(".", "animate", function():void {
				exitScreen();
			});
			
			animate(3);
		}
	}
}