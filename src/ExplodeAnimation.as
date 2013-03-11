package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class ExplodeAnimation extends AnimatedScreen
	{
		public var world:World;
		public var amount:int;
		
		public var previousFireTiles:Array = [];
		public var currentFireTiles:Array = [];
		
		public function ExplodeAnimation(world:World, sx:int, sy:int, amount:int) 
		{
			this.world = world;
			this.amount = amount;
			this.currentFireTiles = [new Point(sx, sy)];
			
			display(function(terminal:AsciiPanel):void {
				for each (var p:Point in previousFireTiles)
				{
					var t:Tile = world.getTile(p.x, p.y);
					var glyph:String = t.glyph;
					var c:Creature = world.getCreature(p.x, p.y);
					if (c != null)
						glyph = c.glyph;
					terminal.write(glyph, p.x, p.y, Color.lerp(t.fg, Color.fire, 0.50), Color.lerp(t.bg, Color.fire, 0.75));
				}
				
				for each (var p:Point in currentFireTiles)
				{
					var t:Tile = world.getTile(p.x, p.y);
					var glyph:String = t.glyph;
					var c:Creature = world.getCreature(p.x, p.y);
					if (c != null)
						glyph = c.glyph;
					terminal.write(glyph, p.x, p.y, Color.lerp(t.fg, Color.fire, 0.10), Color.lerp(t.bg, Color.fire, 0.50));
				}
			});
			
			bind(".", "animate", function():void {
				var nextFireTiles:Array = [];
				
				for each (var p:Point in previousFireTiles)
				{
					var creature:Creature = world.getCreature(p.x, p.y);
					if (creature != null)
					{
						creature.hp -= 1;
						creature.isOnFireCounter++;
					}
				}
				
				for each (var p:Point in currentFireTiles)
				{
					previousFireTiles.push(p);
					
					var creature:Creature = world.getCreature(p.x, p.y);
					if (creature != null)
					{
						creature.hp -= 5;
						creature.isOnFireCounter += 5;
					}
					
					var offsets:Array = [[ -1, 0], [1, 0], [0, -1], [0, 1]];
					if (Math.random() < 0.25)
						offsets.push([-1, -1]);
					if (Math.random() < 0.25)
						offsets.push([ 1, -1]);
					if (Math.random() < 0.25)
						offsets.push([-1,  1]);
					if (Math.random() < 0.25)
						offsets.push([ 1,  1]);
						
					for each (var offset:Array in offsets)
					{
						var x:int = p.x + offset[0];
						var y:int = p.y + offset[1];
						
						var isOk:Boolean = true;
						for each (var p3:Point in nextFireTiles)
						{
							if (p3.x == x && p3.y == y)
							{
								isOk = false;
								break;
							}
						}
						if (!isOk)
							continue;
							
						for each (var p4:Point in previousFireTiles)
						{
							if (p4.x == x && p4.y == y)
							{
								isOk = false;
								break;
							}
						}
						if (!isOk)
							continue;
						
							
						if (world.getTile(x, y) == Tile.closedDoor
						 || world.getTile(x, y) == Tile.openDoor)
						{
							world.setTile(x, y, Tile.burningDoor10);
							amount--;
							nextFireTiles.push(new Point(x,y));
						}
						else if (world.getTile(x, y).allowsVision)
						{
							amount--;
							nextFireTiles.push(new Point(x,y));
						}
					}
				}
				
				currentFireTiles = nextFireTiles;
				
				if (currentFireTiles.length == 0 || amount < 0)
					exitScreen();
			});
			
			animate(30);
		}
	}
}