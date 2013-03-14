package animation
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class Projectile extends AnimatedScreen
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var maxDistance:int;
		public var glyph:String;
		
		public function Projectile(world:World, sx:int, sy:int, ox:int, oy:int, maxDistance:int, magicEffect:Effect) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.maxDistance = maxDistance;
			this.glyph = "*";
			
			if (ox == -1 && oy == -1 || ox == 1 && oy == 1)
				glyph = "\\";
			else if (ox == -1 && oy == 1 || ox == 1 && oy == -1)
				glyph = "/";
			else if (ox == 0 && oy == 1 || ox == 0 && oy == -1)
				glyph = String.fromCharCode(179);
			else if (ox == 1 && oy == 0 || ox == -1 && oy == 0)
				glyph = String.fromCharCode(196);
			
			display(function(terminal:AsciiPanel):void {
				var t:Tile = world.getTile(x, y);
				terminal.write(glyph, x, y, magicEffect.primaryColor, Color.lerp(magicEffect.secondaryColor, t.bg, 0.33));
			});
			
			bind(".", "animate", function():void {
				x += ox;
				y += oy;
				
				var creature:Creature = world.getCreature(x, y);
				if (creature != null)
				{
					magicEffect.applyPrimary(world, x, y);
					exitScreen();
				}
				else if (!world.getTile(x, y).isWalkable || world.getTile(x, y) == Tile.closedDoor)
				{
					magicEffect.applyPrimary(world, x, y);
					exitScreen();
				}
				else if (maxDistance-- < 1)
				{
					magicEffect.applySecondary(world, x, y);
					exitScreen();
				}
			});
			
			animate(30);
		}
	}
}