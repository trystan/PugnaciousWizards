package effects 
{
	public class Teleport implements Effect
	{
		private var caster:Creature;
		
		public function Teleport(caster:Creature)
		{
			this.caster = caster;
		}
		
		public function get primaryColor():int { return 0xffffffff; }
		
		public function get secondaryColor():int { return 0xffeeeeee; }
		
		public function applyPrimary(world:World, x:int, y:int):void
		{
			var creature:Creature = world.getCreature(x, y);
			if (creature == null)
			{
				caster.teleportTo(x, y);
			}
		}
		
		public function applySecondary(world:World, x:int, y:int):void
		{
		}
	}
}