package delivery 
{
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Effect;
	
	public class Pull implements Animation
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var range:int;
		public var radius:int = 1;
		public var magicEffect:Effect;
		
		public function Pull(world:World, x:int, y:int, range:int, magicEffect:Effect) 
		{
			this.world = world;
			this.x = x;
			this.y = y;
			this.range = range;
			this.magicEffect = magicEffect;
		}
		
		public function get isDone():Boolean 
		{
			return radius >= range;
		}
		
		public var movedCreature:Array = [];
		
		public function tick(terminal:AsciiPanel):void 
		{
			for (var ox:int = -radius; ox <= radius; ox++)
			for (var oy:int = -radius; oy <= radius; oy++)
			{
				terminal.withLocation(x + ox, y + oy, function(c:int, fg:int, bg:int):void {
					terminal.write(String.fromCharCode(c), x + ox, y + oy, Color.lerp(fg, magicEffect.secondaryColor, 0.9), Color.lerp(bg, magicEffect.secondaryColor, 0.9));
				});
				
				var c:Creature = world.getCreature(x + ox, y + oy);
				
				if (c == null)
					continue;
				
				if (movedCreature.indexOf(c) > -1)
					magicEffect.applyPrimary(world, c.x, c.y);
				else
					magicEffect.applySecondary(world, c.x, c.y);
				
				var nextX:int = x + ox;
				var nextY:int = y + oy;
					
				if (ox > 0)
					nextX--;
				else if (ox < 0)
					nextX++;
				
				if (oy > 0)
					nextY--;
				else if (oy < 0)
					nextY++;
					
				if (world.getCreature(nextX, nextY) != null)
				{
					if (movedCreature.indexOf(c) > -1)
					{
						c.hp--;
						c.bleed();
					}
					continue;
				}
				
				if (!world.getTile(nextX, nextY).isWalkable)
				{					
					if (movedCreature.indexOf(c) > -1)
					{
						c.hp--;
						c.bleed();
					}
					continue;
				}
				
				if (movedCreature.indexOf(c) == -1)
					movedCreature.push(c);
				
				c.teleportTo(nextX, nextY);
			}
			radius++;
		}
	}
}