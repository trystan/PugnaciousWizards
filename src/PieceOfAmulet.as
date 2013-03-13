package  
{
	public class PieceOfAmulet extends Item
	{
		public function PieceOfAmulet(x:int, y:int) 
		{
			super(String.fromCharCode(15), Color.hsv(60, 90, 90), x, y, "piece of amulet");
		}
	}
}