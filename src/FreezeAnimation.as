package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class FreezeAnimation extends AnimatedScreen
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var countDown:int;
		public var path:Array;
		
		public function FreezeAnimation(world:World, sx:int, sy:int, ox:int, oy:int) 
		{
			this.world = world;
			this.x = sx;
			this.y = sy;
			this.ox = ox;
			this.oy = oy;
			this.countDown = 9;
			this.path = [];
			
			display(function(terminal:AsciiPanel):void {
				var ice:int = Color.hsv(215, 70, 95);
				for each (var p:Point in path)
				{
					var glyph:String = " ";
					var c:Creature = world.getCreature(p.x, p.y);
					if (c != null)
						glyph = c.glyph;
					var t:Tile = world.getTile(p.x, p.y);
					terminal.write(glyph, p.x, p.y, ice, Color.lerp(ice, t.bg, 0.25));
				}
				
				var glyph:String = " ";
				var c:Creature = world.getCreature(x, y);
				if (c != null)
					glyph = c.glyph;
				var t:Tile = world.getTile(x, y);
				terminal.write(glyph, x, y, ice, Color.lerp(ice, t.bg, 0.90));
			});
			
			bind(".", "animate", function():void {
				path.push(new Point(x, y));
				x += ox;
				y += oy;
				
				if (x < 0 || y < 0 || x > 78 || y > 78)
				{
					exitScreen();
					return;
				}
				
				var creature:Creature = world.getCreature(x, y);
				if (creature != null)
				{
					creature.isFrozenCounter = 12;
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