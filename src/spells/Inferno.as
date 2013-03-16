package spells
{
	import targeting.ChooseAVisibleOccupiedTile;
	import delivery.Explosion;
	import effects.Fire;
	import targeting.Targeting;
	
	public class Inferno implements Magic
	{
		public function get name():String { return "Inferno"; }
		
		public function get description():String { return "Create an explosion of fire that's trong enough to fill nine rooms. Not a very safe spell."; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return targetWith(caster).calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			targetWith(creature).playerCast(creature);
		}
		
		private function targetWith(creature:Creature):Targeting
		{
			return new ChooseAVisibleOccupiedTile(12, 30,  
				function (world:World, x:int, y:int):Explosion {
						return new Explosion(world, x, y, 49 * 9, new Fire(10));
				});
		}
	}
}