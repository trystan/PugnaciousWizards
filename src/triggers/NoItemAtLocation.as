package triggers 
{
	public class NoItemAtLocation implements Trigger
	{
		public var x:int;
		public var y:int;
		
		public function NoItemAtLocation(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
		}
		
		public function check(world:World):Boolean 
		{
			return world.getItem(x, y) == null;
		}
	}
}