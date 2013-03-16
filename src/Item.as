package  
{
	public class Item 
	{
		public var glyph:String;
		public var fg:int;
		public var x:int;
		public var y:int;
		public var world:World;
		public var name:String;
		public var description:String = null;
		
		public function Item(glyph:String, fg:int, x:int, y:int, name:String) 
		{
			this.glyph = glyph;
			this.fg = fg;
			this.x = x;
			this.y = y;
			this.name = name;
		}
		
		public function update():void
		{
			
		}
	}
}