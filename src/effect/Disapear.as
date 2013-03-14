package effect 
{
	public class Disapear implements Effect
	{
		private var caster:Creature;
		
		public function Disapear(caster:Creature)
		{
			this.caster = caster;
		}
		
		public function get primaryColor():int { return 0xffffffff; }
		
		public function get secondaryColor():int { return 0xffeeeeee; }
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			caster.teleportTo(-2, -2);
		}
		
		public function applySecondary(world:World, x:int, y:int):void
		{
		}
	}
}