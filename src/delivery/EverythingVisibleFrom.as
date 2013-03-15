package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Effect;
	import flash.geom.Point;
	
	public class EverythingVisibleFrom implements Animation
	{
		public var world:World;
		public var fov:FieldOfView;
		public var magicEffect:Effect;
		
		public function EverythingVisibleFrom(world:World, x:int, y:int, range:int, magicEffect:Effect) 
		{
			this.world = world;
			this.fov = new FieldOfView();
			this.magicEffect = magicEffect;
			
			fov.calculateVisibility(x, y, range, function(vx:int, vy:int):Boolean {
				return world.getTile(vx, vy).allowsVision;
			});
		}
		
		public function get isDone():Boolean 
		{
			return true;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			var points:Array = [];
			for (var x:int = 0; x < 80; x++)
			for (var y:int = 0; y < 80; y++)
			{
				if (!fov.isVisibleNow(x, y))
					continue;
				
				if (world.hero.canSeeLocation(x, y))
					terminal.write(" ", x, y, magicEffect.primaryColor, magicEffect.secondaryColor);
					
				points.push(new Point(x, y));
			}
			
			for each (var point:Point in points)
			{
				magicEffect.applyPrimary(world, point.x, point.y);
			}
		}
	}
}