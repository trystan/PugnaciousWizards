package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class MagicMissileAnimation extends AnimatedScreen
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var countDown:int;
		public var glyph:String;
		
		public function MagicMissileAnimation(world:World, sx:int, sy:int, ox:int, oy:int, countDown:int) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.countDown = countDown;
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
				terminal.write(glyph, x, y, Color.hsv(220, 95, 95), Color.lerp(Color.hsv(220, 90, 90), t.bg, 0.33));
			});
			
			bind(".", "animate", function():void {
				x += ox;
				y += oy;
				
				var creature:Creature = world.getCreature(x, y);
				if (creature != null)
				{
					creature.hp -= 10;
					creature.bleed();
					exitScreen();
				}
				else if (!world.getTile(x, y).isWalkable || world.getTile(x, y) == Tile.closedDoor)
				{
					exitScreen();
				}
				else if (countDown-- < 1)
				{
					exitScreen();
				}
			});
			
			animate(30);
		}
	}
}