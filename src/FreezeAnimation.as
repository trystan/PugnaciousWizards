package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class FreezeAnimation extends BaseScreen
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var ox:int;
		public var oy:int;
		public var countDown:int;
		public var glyph:String;
		public var path:Array;
		
		public var intervalTimeout:int = 0;
		
		public function FreezeAnimation(world:World, sx:int, sy:int, ox:int, oy:int) 
		{
			this.world = world;
			this.x = sx + ox;
			this.y = sy + oy;
			this.ox = ox;
			this.oy = oy;
			this.countDown = 9;
			this.glyph = "*";
			this.path = [];
			
			display(function(terminal:AsciiPanel):void {
				for each (var p:Point in path)
				{
					var t:Tile = world.getTile(p.x, p.y);
					terminal.write(glyph, p.x, p.y, Color.hsv(250, 60, 80), t.bg);
				}
				
				var t:Tile = world.getTile(x, y);
				terminal.write(glyph, x, y, Color.hsv(250, 90, 80), t.bg);
			});
			
			bind(".", "step", function():void {
				path.push(new Point(x, y));
				x += ox;
				y += oy;
				
				if (x < 0 || y < 0 || x > 78 || y > 78)
				{
					clearInterval(intervalTimeout);
					exitScreen();
					return;
				}
				
				var creature:Creature = world.getCreature(x, y);
				if (creature != null)
				{
					creature.isFrozenCounter = 12;
					clearInterval(intervalTimeout);
					exitScreen();
				}
				else if (!world.getTile(x, y).isWalkable || world.getTile(x, y) == Tile.closedDoor)
				{
					clearInterval(intervalTimeout);
					exitScreen();
				}
				else if (countDown-- < 1)
				{
					clearInterval(intervalTimeout);
					exitScreen();
				}
			});
			
			BeginQuickTime();
		}
		
		private function BeginQuickTime():void 
		{
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 46, 190);
			intervalTimeout = setInterval(RL.instance.handleKeyboardEvent, 1000 / 30, event);
		}
	}
}