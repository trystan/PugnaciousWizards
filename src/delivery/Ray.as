package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Effect;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class Ray implements Animation
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var maxDistance:int;
		public var path:Array;
		public var magicEffect:Effect;
		public var callback:Function;
		
		public function Ray(world:World, sx:int, sy:int, ox:int, oy:int, maxDistance:int, magicEffect:Effect, callback:Function) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.maxDistance = maxDistance;
			this.path = [];
			this.magicEffect = magicEffect;
			this.callback = callback;
		}
		
		private var _isDone:Boolean = false;
		public function get isDone():Boolean 
		{
			return _isDone;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			path.push(new Point(x, y));
			x += ox;
			y += oy;
			
			if (x < 0 || y < 0 || x > 78 || y > 78)
			{
				_isDone = true;
				return;
			}
			
			var creature:Creature = world.getCreature(x, y);
			if (creature != null)
			{
				callback(world, x, y);
				_isDone = true;
			}
			else if (!world.getTile(x, y).isWalkable || world.getTile(x, y) == Tile.closedDoor)
			{
				callback(world, x, y);
				_isDone = true;
			}
			else if (maxDistance-- < 1)
			{
				callback(world, x, y);
				_isDone = true;
			}
			
			if (isDone)
				return;
			
			if (world.hero.canSeeLocation(x, y))
				terminal.withLocation(x, y, function(c:int, fg:int, bg:int):void {
					terminal.write(String.fromCharCode(c), x, y, Color.lerp(magicEffect.primaryColor, fg, 0.33), Color.lerp(magicEffect.primaryColor, bg, 0.33));
				});
			
			for each (var p:Point in path)
			{
				if (world.hero.canSeeLocation(p.x, p.y))
					terminal.withLocation(p.x, p.y, function(c:int, fg:int, bg:int):void {
						terminal.write(String.fromCharCode(c), p.x, p.y, Color.lerp(magicEffect.secondaryColor, fg, 0.33), Color.lerp(magicEffect.secondaryColor, bg, 0.33));
					});
			}
		}
	}
}