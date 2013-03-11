package
{
	public class PileOfBones extends Item
	{
		public var countDown:int;
		
		public function PileOfBones(x:int, y:int) 
		{
			super(";", Color.hsv(0, 0, 50), x, y);
			
			this.countDown = 50;
		}
		
		override public function update():void
		{
			if (countDown-- < 1 && world.getCreature(x, y) == null)
			{
				world.removeItem(this);
				world.addCreature(new Skeleton(x, y));
			}
		}
	}
}