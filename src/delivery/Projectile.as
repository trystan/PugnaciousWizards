package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Effect;
	
	public class Projectile implements Animation
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var maxDistance:int;
		public var glyph:String;
		public var magicEffect:Effect;
		public var callback:Function
		
		public function Projectile(world:World, sx:int, sy:int, ox:int, oy:int, maxDistance:int, magicEffect:Effect, callback:Function) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.maxDistance = maxDistance;
			this.glyph = "*";
			this.magicEffect = magicEffect;
			this.callback = callback;
			
			if (ox == -1 && oy == -1 || ox == 1 && oy == 1)
				glyph = "\\";
			else if (ox == -1 && oy == 1 || ox == 1 && oy == -1)
				glyph = "/";
			else if (ox == 0 && oy == 1 || ox == 0 && oy == -1)
				glyph = String.fromCharCode(179);
			else if (ox == 1 && oy == 0 || ox == -1 && oy == 0)
				glyph = String.fromCharCode(196);
		}
		
		private var _isDone:Boolean = false;
		public function get isDone():Boolean 
		{
			return _isDone;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			x += ox;
			y += oy;
			
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
				_isDone = true;
			}
			
			terminal.withLocation(x, y, function(c:int, fg:int, bg:int):void {
				terminal.write(glyph, x, y, magicEffect.primaryColor, Color.lerp(bg, magicEffect.secondaryColor, 0.7));
			});
		}
	}
}