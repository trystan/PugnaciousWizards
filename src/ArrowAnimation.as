package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;
	
	public class ArrowAnimation extends BaseScreen
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
				terminal.write(glyph, x, y, 0xffffff, t.bg);
			});
			
			bind(".", "step", function():void {
				x += ox;
				y += oy;
				
				var creature:Creature = world.getCreature(x, y);
				if (creature != null)
				{
					creature.hp -= 10;
					exitScreen();
				}
				else if (!world.getTile(x, y).isWalkable)
				{
					exitScreen();
				}
				else if (countDown-- < 1)
				{
					exitScreen();
				}
			});
		}
	}
}