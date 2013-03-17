package spells
{
	import delivery.Composite;
	import effects.Ice;
	import targeting.Self;
	import delivery.Explosion;
	
	public class FreezeTrap implements Magic
	{
		public function get name():String { return "Freeze trap"; }
		
		public function get description():String { return "Places a trap where you're standing. The next creature to step on it will trigger a freezing explosion."; }
		
		private var action:Self = new Self(
			function (world:World, x:int, y:int):Animation {
				var armedCountdown:int = 1;
				world.addTriggerForEveryTurn(function():void {
					if (armedCountdown-- < 0 && world.getCreature(x, y) != null)
					{
						world.addAnimation(new Explosion(world, x, y, 49, new Ice()));
						world.setTile(x, y, Tile.exposedTrap);
						armedCountdown = world.getCreature(x,y).isFrozenCounter + 12;
					}
				})
				return new Composite([]);
			});
			
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(caster.isOnFireCounter > 10 ? 33 : 5, function():void {
				action.castAtLocationCallback(caster.world, caster.x, caster.y);
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			action.playerCast(creature);
		}
	}
}