package  
{
	public class MagicSpell implements Magic
	{
		private var effects:Array;
		
		public function MagicSpell(...rest) 
		{
			this.effects = rest;
		}
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var total:int = 0;
			var actions:Array = [];
			
			for each (var effect:Magic in effects)
			{
				var action:MagicAction = effect.calculateAiBenefit(caster);
				total += action.benefit;
				actions.push(action.action);
			}
			
			return new MagicAction(total, function(c:Creature):void {
				for each (var f:Function in actions)
					f(c);
			});
		}
		
		public function playerCast(caster:Creature):void 
		{
			for each (var effect:Magic in effects)
				effect.playerCast(caster);
		}
	}
}