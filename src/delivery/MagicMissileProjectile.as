package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class MagicMissileProjectile implements Animation
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var maxDistance:int;
		public var glyph:String;
		public var magicEffect:Effect;
		
		public function MagicMissileProjectile(world:World, sx:int, sy:int, mx:int, my:int, maxDistance:int, magicEffect:Effect) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = mx;
			this.oy = my;
			this.maxDistance = maxDistance;
			this.magicEffect = magicEffect;
			
			calculateGlyph();
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
			
			if (maxDistance-- < 1)
			{
				_isDone = true;
			}
			else if (creature != null)
			{
				magicEffect.applyPrimary(world, x, y);
				ox = Math.floor(Math.random() * 3) - 1;
				oy = Math.floor(Math.random() * 3) - 1;
				calculateGlyph();
			}
			else if (!world.getTile(x, y).isWalkable || world.getTile(x, y) == Tile.closedDoor)
			{
				x -= ox;
				y -= oy;
				ox = Math.floor(Math.random() * 3) - 1;
				oy = Math.floor(Math.random() * 3) - 1;
				calculateGlyph();
			}
			
			if (!isDone)
			{
				var t:Tile = world.getTile(x, y);
				terminal.write(glyph, x, y, magicEffect.primaryColor, Color.lerp(magicEffect.secondaryColor, t.bg, 0.33));
			}
		}
		
		private function calculateGlyph():void 
		{
			if (ox == -1 && oy == -1 || ox == 1 && oy == 1)
				glyph = "\\";
			else if (ox == -1 && oy == 1 || ox == 1 && oy == -1)
				glyph = "/";
			else if (ox == 0 && oy == 1 || ox == 0 && oy == -1)
				glyph = String.fromCharCode(179);
			else if (ox == 1 && oy == 0 || ox == -1 && oy == 0)
				glyph = String.fromCharCode(196);
			else
				glyph = "*";
		}
	}
}