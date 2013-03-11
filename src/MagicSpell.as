package  
{
	public class MagicSpell implements Magic
	{
		private var effects:Array;
		
		public function MagicSpell(...rest) 
		{
			this.effects = rest;
		}
		
		public function playerCast(caster:Creature):void 
		{
			for each (var effect:Magic in effects)
				effect.playerCast(caster);
		}
	}
}