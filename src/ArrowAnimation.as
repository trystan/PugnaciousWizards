package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class ArrowAnimation extends AnimatedScreen
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var countDown:int;
		public var glyph:String;
		
		public function ArrowAnimation(world:World, sx:int, sy:int, ox:int, oy:int) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.countDown = 9;
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
				terminal.write(glyph, x, y, Color.hsv(36, 50, 90), t.bg);
			});
			
			bind(".", "step", function():void {
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