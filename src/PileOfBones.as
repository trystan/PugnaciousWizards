package  
{
	public class PileOfBones 
	{
		public var glyph:String;
		public var fg:int;
		public var x:int;
		public var y:int;
		public var world:World;
		
		public var countDown:int;
		
		public function PileOfBones(x:int, y:int) 
		{
			this.glyph = ";";
			this.fg = Color.hsv(0, 0, 50);
			this.x = x;
			this.y = y;
			this.countDown = 50;
		}
		
		public function update():void
		{
			trace(countDown);
			if (countDown-- < 1)
			{
				world.removeItem(this);
				world.addCreature(new Skeleton(x, y));
			}
		}
	}
}