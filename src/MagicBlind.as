package  
{
	import effect.Blind;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	import animation.EverythingVisible;
	
	public class MagicBlind implements Magic
	{
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			return new MagicAction(0, function(c:Creature):void {
				playerCast(caster);
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			creature.world.addAnimation(new EverythingVisible(creature, new Blind()));
		}
	}
}