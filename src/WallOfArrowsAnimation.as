package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class WallOfArrowsAnimation implements Animation
	{
		public var arrows:Array = [];
		public var world:World;
		public var restart:Boolean = true;
		public var points:Array;
		public var ox:int;
		public var oy:int;
		
		public function WallOfArrowsAnimation(world:World, points:Array, ox:int, oy:int) 
		{
			this.world = world;
			this.points = points;
			this.ox = ox;
			this.oy = oy;
		}
		
		public function get isDone():Boolean
		{
			if (arrows.length == 0)
				restart = true;
			return restart;
		}
		
		public function tick(terminal:AsciiPanel):void
		{
			if (restart)
			{	
				restart = false;
				for each (var p:Point in points)
					arrows.push(new Arrow(p.x, p.y, ox, oy, 7));
			}
			
			var alive:Array = [];
			for each (var arrow:Arrow in arrows)
			{
				arrow.x += arrow.ox;
				arrow.y += arrow.oy;
				
				var creature:Creature = world.getCreature(arrow.x, arrow.y);
				if (creature != null)
				{
					creature.hp -= 5;
					creature.bleed();
					
					HelpSystem.notify(creature, "Arrow traps", null, "You've been hit by an arrow that shot out of the wall. It's probablly not a good idea to hang out here to too long....");
				}
				else if (!world.getTile(arrow.x, arrow.y).isWalkable 
					   || world.getTile(arrow.x, arrow.y) == Tile.closedDoor)
				{
				}
				else if (arrow.range-- < 1)
				{
				}
				else
				{
					alive.push(arrow);
				}
			}
			arrows = alive;
			
			for each (var arrow:Arrow in arrows)
			{
				var t:Tile = world.getTile(arrow.x, arrow.y);
				terminal.write(arrow.glyph, arrow.x, arrow.y, Color.hsv(36, 50, 90), t.bg);
			}
		}
	}
}

class Arrow
{
	public var x:int;
	public var y:int;
	public var ox:int;
	public var oy:int;
	public var range:int;
	public var glyph:String;
	
	public function Arrow(x:int, y:int, ox:int, oy:int, range:int)
	{
		this.x = x;
		this.y = y;
		this.ox = ox;
		this.oy = oy;
		this.range = range;
		this.glyph = "*";
		
		if (ox == 0 && oy == -1)
			this.glyph = String.fromCharCode(24);
		else if (ox == 0 && oy == 1)
			this.glyph = String.fromCharCode(25);
		else if (ox == -1 && oy == 0)
			this.glyph = String.fromCharCode(27);
		else if (ox == 1 && oy == 0)
			this.glyph = String.fromCharCode(26);
	}
}