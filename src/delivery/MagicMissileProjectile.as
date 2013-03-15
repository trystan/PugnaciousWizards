package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class MagicMissileProjectile implements Animation
	{
		public var world:World;
		public var projectiles:Array;
		public var magicEffect:Effect;
		
		public function MagicMissileProjectile(world:World, sx:int, sy:int, mx:int, my:int, maxDistance:int, magicEffect:Effect) 
		{
			this.world = world;
			this.projectiles = [new MagicProjectile(sx, sy, mx, my, maxDistance)];
			this.magicEffect = magicEffect;
		}
		
		public function get isDone():Boolean 
		{
			return projectiles.length == 0;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			var nextProjectiles:Array = [];
			for each (var p:MagicProjectile in projectiles)
			{
				p.x += p.ox;
				p.y += p.oy;
				
				var creature:Creature = world.getCreature(p.x, p.y);
				
				if (p.range-- < 1)
				{
				}
				else if (creature != null)
				{
					magicEffect.applyPrimary(world, p.x, p.y);
					
					var isCardinal:Boolean = p.ox == 0 || p.oy == 0;
					
					if (isCardinal)
						addDiagonals(nextProjectiles, p);
					else
						addCardinals(nextProjectiles, p);
				}
				else if (!world.getTile(p.x, p.y).isWalkable || world.getTile(p.x, p.y) == Tile.closedDoor)
				{
					if (p.ox == 0)
					{
						if (world.getTile(p.x - 1, p.y - p.oy).isWalkable)
							nextProjectiles.push(new MagicProjectile(p.x, p.y - p.oy, -1,  0, p.range));
						if (world.getTile(p.x + 1, p.y - p.oy).isWalkable)
							nextProjectiles.push(new MagicProjectile(p.x, p.y - p.oy,  1,  0, p.range));
					}
					else if (p.oy == 0)
					{
						if (world.getTile(p.x - p.ox, p.y - 1).isWalkable)
							nextProjectiles.push(new MagicProjectile(p.x - p.ox, p.y, 0, -1, p.range));
						if (world.getTile(p.x - p.ox, p.y + 1).isWalkable)
							nextProjectiles.push(new MagicProjectile(p.x - p.ox, p.y, 0,  1, p.range));
					}
					else
					{
						if (world.getTile(p.x, p.y - p.oy * 2).isWalkable)
							nextProjectiles.push(new MagicProjectile(p.x - p.ox, p.y - p.oy, p.ox, -p.oy, p.range));
						if (world.getTile(p.x - p.ox * 2, p.y).isWalkable)
							nextProjectiles.push(new MagicProjectile(p.x - p.ox, p.y - p.oy, -p.ox, p.oy, p.range));
					}
				}
				else 
				{
					nextProjectiles.push(p);
				}
				
				if (!isDone && world.hero.canSeeLocation(p.x, p.y))
				{
					var t:Tile = world.getTile(p.x, p.y);
					terminal.write(p.glyph, p.x, p.y, magicEffect.primaryColor, Color.lerp(magicEffect.secondaryColor, t.bg, 0.33));
				}
				
				projectiles = nextProjectiles;
			}
		}
		
		private function addCardinals(nextProjectiles:Array, p:MagicProjectile):void 
		{
			nextProjectiles.push(new MagicProjectile(p.x, p.y, -1,  0, p.range/2));
			nextProjectiles.push(new MagicProjectile(p.x, p.y,  1,  0, p.range/2));
			nextProjectiles.push(new MagicProjectile(p.x, p.y,  0, -1, p.range/2));
			nextProjectiles.push(new MagicProjectile(p.x, p.y,  0,  1, p.range/2));
		}
		
		private function addDiagonals(nextProjectiles:Array, p:MagicProjectile):void 
		{
			nextProjectiles.push(new MagicProjectile(p.x, p.y, -1, -1, p.range/2));
			nextProjectiles.push(new MagicProjectile(p.x, p.y, -1,  1, p.range/2));
			nextProjectiles.push(new MagicProjectile(p.x, p.y,  1, -1, p.range/2));
			nextProjectiles.push(new MagicProjectile(p.x, p.y,  1,  1, p.range/2));
		}
	}
}

class MagicProjectile
{
	public var x:int;
	public var y:int;
	public var ox:int;
	public var oy:int;
	public var range:int;
	public var glyph:String;
	
	public function MagicProjectile(x:int, y:int, ox:int, oy:int, range:int)
	{
		this.x = x;
		this.y = y;
		this.ox = ox;
		this.oy = oy;
		this.range = range;
		this.glyph = "*";
		
		if (ox == -1 && oy == -1 || ox == 1 && oy == 1)
			glyph = "\\";
		else if (ox == -1 && oy == 1 || ox == 1 && oy == -1)
			glyph = "/";
		else if (ox == 0 && oy == 1 || ox == 0 && oy == -1)
			glyph = String.fromCharCode(179);
		else if (ox == 1 && oy == 0 || ox == -1 && oy == 0)
			glyph = String.fromCharCode(196);
		else
			glyph = "*";
	}
}