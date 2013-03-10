package  
{
	public class Item 
	{
		public var glyph:String;
		public var fg:int;
		public var x:int;
		public var y:int;
		public var world:World;
		
		public function Item(glyph:String, fg:int, x:int, y:int) 
		{
			this.glyph = glyph;
			this.fg = fg;
			this.x = x;
			this.y = y;
		}
		
		public function update():void
		{
			
		}
	}
}