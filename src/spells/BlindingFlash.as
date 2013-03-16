package spells
{
	import delivery.EverythingVisibleFrom;
	import targeting.ChooseAVisibleOccupiedTile;
	import effects.Blind;
	
	public class BlindingFlash implements Magic
	{
		public function get name():String { return "Blinding flash"; }
		
		public function get description():String { return "Creates a bright light at a choosen location. Everyone who sees it will be blinded for a few turns."; }
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return targetWith(caster).calculateAiBenefit(caster);
		}
		
		public function playerCast(creature:Creature):void
		{
			targetWith(creature).playerCast(creature);
		}
		
		private function targetWith(creature:Creature):ChooseAVisibleOccupiedTile
		{
			return new ChooseAVisibleOccupiedTile(8, 12,
				function (world:World, x:int, y:int):EverythingVisibleFrom {
					return new EverythingVisibleFrom(world, x, y, creature.viewDistance / 2, new Blind());
				});
		}
	}
}