package  
{
	public class Scroll extends Item
	{		
		public var spell:Magic;
		
		public function Scroll(x:int, y:int, spell:Magic)
		{
			super("?", 0xffdddddd, x, y, "Scroll of " + spell.name);
			this.spell = spell;
		}
	}
}