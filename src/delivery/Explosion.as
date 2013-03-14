package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	import effect.Effect;
	
	public class Explosion extends AnimatedScreen
	{
		public var world:World;
		public var amount:int;
		
		public var interiorPoints:Array = [];
		public var edgePoints:Array = [];
		
		public function Explosion(world:World, sx:int, sy:int, amount:int, magicEffect:Effect) 
		{
			this.world = world;
			this.amount = amount;
			this.edgePoints = [new Point(sx, sy)];
			
			var fg:int = magicEffect.primaryColor;
			var bg:int = magicEffect.secondaryColor;
			
			display(function(terminal:AsciiPanel):void {
				for each (var p:Point in interiorPoints)
				{
					var t:Tile = world.getTile(p.x, p.y);
					var glyph:String = t.glyph;
					var c:Creature = world.getCreature(p.x, p.y);
					if (c != null)
						glyph = c.glyph;
					terminal.write(glyph, p.x, p.y, Color.lerp(t.fg, fg, 0.50), Color.lerp(t.bg, bg, 0.75));
				}
				
				for each (var p:Point in edgePoints)
				{
					var t:Tile = world.getTile(p.x, p.y);
					var glyph:String = t.glyph;
					var c:Creature = world.getCreature(p.x, p.y);
					if (c != null)
						glyph = c.glyph;
					terminal.write(glyph, p.x, p.y, Color.lerp(t.fg, fg, 0.10), Color.lerp(t.bg, bg, 0.50));
				}
			});
			
			bind(".", "animate", function():void {
				var nextFireTiles:Array = [];
				
				for each (var p:Point in interiorPoints)
				{
					magicEffect.applySecondary(world, p.x, p.y);
				}
				
				for each (var p:Point in edgePoints)
				{
					interiorPoints.push(p);
					
					magicEffect.applyPrimary(world, p.x, p.y);
					
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
							
						for each (var p4:Point in interiorPoints)
						{
							if (p4.x == x && p4.y == y)
							{
								isOk = false;
								break;
							}
						}
						if (!isOk)
							continue;
						
						var here:Tile = world.getTile(x, y);
						if (here == Tile.closedDoor || here == Tile.openDoor)
						{
							amount--;
							nextFireTiles.push(new Point(x,y));
						}
						else if (here.isTree)
						{
							amount -= 3;
							nextFireTiles.push(new Point(x, y));
						}
						else if (here.allowsVision)
						{
							amount--;
							nextFireTiles.push(new Point(x,y));
						}
					}
				}
				
				edgePoints = nextFireTiles;
				
				if (edgePoints.length == 0 || amount < 0)
					exitScreen();
			});
			
			animate(30);
		}
	}
}