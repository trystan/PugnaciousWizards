package  
{
	import animation.RandomVisibleSpace;
	import effect.Teleport;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	
	public class MagicBlink implements Magic
	{
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			var total:int = 0;
			
			var dirs:Array = [[ -1, -1], [ -0, -1], [ +1, -1],
							  [ -1, -0],            [ +1, -0],
							  [ -1, +1], [ -0, +1], [ +1, +1]];
			
			for each (var offset:Array in dirs)
			{
				if (caster.doesHate(caster.world.getCreature(caster.x + offset[0], caster.y + offset[1])))
					total++;
			}

			return new MagicAction(total * 10, function(c:Creature):void {
				playerCast(caster);
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			creature.world.addAnimation(new RandomVisibleSpace(creature, new Teleport(creature)));
		}
	}
}