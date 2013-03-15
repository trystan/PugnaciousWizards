package effects 
{
	import effects.Effect;
	
	public class BloodToHealth implements Effect 
	{
		public var target:Creature;
		
		public function BloodToHealth(creature:Creature) 
		{
			target = creature;
		}
	
		public function get primaryColor():int { return Color.hsv(10, 60, 60); }
		
		public function get secondaryColor():int { return Color.hsv(10, 50, 50); }
		
		public function applyPrimary(world:World, x:int, y:int):void 
		{
			var amount = world.getBlood(x, y);
			
			target.heal(amount / 2);
			
			world.removeBlood(x, y);
		}
		
		public function applySecondary(world:World, x:int, y:int):void 
		{
		}
	}
}