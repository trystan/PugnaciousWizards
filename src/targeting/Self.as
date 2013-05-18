package targeting 
{
	public class Self implements Targeting
	{
		public var castAtLocationCallback:Function;
		
		public function Self(castAtLocationCallback:Function)
		{
			this.castAtLocationCallback = castAtLocationCallback;
		}
		
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(10, function(c:Creature):void {
				c.world.addAnimation(castAtLocationCallback(caster.world, caster.x, caster.y));
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			creature.world.addAnimation(castAtLocationCallback(creature.world, creature.x, creature.y), Game.current.endTurn);
		}
	}
}