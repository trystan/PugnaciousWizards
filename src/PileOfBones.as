package
{
	public class PileOfBones extends Item
	{
		public var countDown:int;
		
		public function PileOfBones(x:int, y:int, reanimates:Boolean = true) 
		{
			super(";", Color.hsv(0, 0, 50), x, y, "pile of bones");
			
			this.countDown = reanimates ? 50 : -1;
		}
		
		override public function update():void
		{
			if (countDown == -1)
				return;
				
			if (countDown-- < 1 && world.getCreature(x, y) == null)
			{
				world.removeItem(this);
				world.addCreature(new Skeleton(x, y));
			}
		}
	}
}