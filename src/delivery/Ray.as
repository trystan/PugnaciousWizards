package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
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
		
		public function Ray(world:World, sx:int, sy:int, ox:int, oy:int, maxDistance:int, magicEffect:Effect) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.maxDistance = maxDistance;
			this.path = [];
			this.magicEffect = magicEffect;
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
				magicEffect.applyPrimary(world, x, y);
				_isDone = true;
			}
			else if (!world.getTile(x, y).isWalkable || world.getTile(x, y) == Tile.closedDoor)
			{
				magicEffect.applyPrimary(world, x, y);
				_isDone = true;
			}
			else if (maxDistance-- < 1)
			{
				magicEffect.applySecondary(world, x, y);
				_isDone = true;
			}
			for each (var p:Point in path)
			{
				var glyph:String = " ";
				var c:Creature = world.getCreature(p.x, p.y);
				if (c != null)
					glyph = c.glyph;
				var t:Tile = world.getTile(p.x, p.y);
				terminal.write(glyph, p.x, p.y, magicEffect.primaryColor, Color.lerp(magicEffect.primaryColor, t.bg, 0.25));
			}
			
			if (!isDone)
			{
				var glyph:String = " ";
				var c:Creature = world.getCreature(x, y);
				if (c != null)
					glyph = c.glyph;
				var t:Tile = world.getTile(x, y);
				terminal.write(glyph, x, y, magicEffect.secondaryColor, Color.lerp(magicEffect.secondaryColor, t.bg, 0.90));
			}
		}
	}
}