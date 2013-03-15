package spells
{
	import delivery.Composite;
	import delivery.EverythingVisibleFrom;
	import effects.MagicDamage;
	import targeting.Self;
	import delivery.Explosion;
	
	public class TimedDeath implements Magic
	{
		public function get name():String { return "Timed death"; }
		
		private var action:Self = new Self(
			function (world:World, x:int, y:int):Animation {
				world.setTile(x, y, Tile.timer5);
				var nextTurn:Boolean = false;
				world.addTriggerForEveryTurn(function():void {
					if (nextTurn)
						world.addAnimation(new EverythingVisibleFrom(world, x, y, 49 * 5, new MagicDamage(66)));
					
					nextTurn = world.getTile(x, y) == Tile.timer0;
				})
				return new Composite([]);
			});
			
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(1, function():void {
				caster.world.setTile(caster.x, caster.y, Tile.timer5);
				caster.world.addTriggerForEveryTurn(function():void {
					if (caster.world.getTile(caster.x, caster.y) == Tile.timer0)
						caster.world.addAnimation(new EverythingVisibleFrom(caster.world, caster.x, caster.y, 49 * 5, new MagicDamage(33)));
				})
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			action.playerCast(creature);
		}
	}
}