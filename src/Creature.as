package  
{
	import flash.automation.ActionGenerator;
	public class Creature 
	{
		public var glyph:String;
		public var fg:int;
		public var x:int;
		public var y:int;
		public var world:World;
		
		public var hp:int;
		
		public function Creature(glyph:String, fg:int, x:int, y:int) 
		{
			this.glyph = glyph;
			this.fg = fg;
			this.x = x;
			this.y = y;
			this.hp = 100;
		}
		
		public function doAi():void
		{
			
		}
		
		public function walk(mx:int, my:int):void
		{
			if (mx == 0 && my == 0)
				return;
			
			var other:Creature = world.getCreature(x + mx, y + my);
			
			if (other != null)
			{
				attack(other);
			}
			else if (world.getTile(x + mx, y + my) == Tile.closedDoor)
			{
				world.setTile(x + mx, y + my, Tile.openDoor);
			}
			else if (world.getTile(x + mx, y + my).isWalkable)
			{
				x += mx;
				y += my;
			}
		}
		
		public function attack(other:Creature):void
		{
			other.hp = 0;
		}
		
		public function wander():void
		{
			var mx:int = Math.floor(Math.random() * 3 - 1);
			var my:int = Math.floor(Math.random() * 3 - 1);
			
			walk(mx, my);
		}
	}
}