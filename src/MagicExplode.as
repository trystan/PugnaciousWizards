package  
{
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	
	public class MagicExplode implements Magic
	{
		private static var points:Array = null;
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			if (points == null)
			{
				points = [];
				for (var radius:int = 8; radius < 12; radius++)
				{
					for (var angle:int = 0; angle < 360; angle += 10)
					{
						var rads:Number = angle * Math.PI / 180;
						points.push(new Point(radius * Math.sin(rads), radius * Math.cos(rads)));
					}
				}
			}
			
			var candidates:Array = [];
			for each (var p:Point in points)
			{
				var candidate:MagicAction = getCandidate(caster, p);
				if (candidate != null)
					candidates.push(candidate);
			}
			
			if (candidates.length > 0)
				return candidates[Math.floor(Math.random() * candidates.length)];
				
			return new MagicAction(0, function(c:Creature):void {
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			RL.enterScreen(new TargetVisibleTileScreen(creature.x, creature.y, creature.viewDistance, creature.world, function(x:int, y:int):void {
				creature.world.addAnimation(new ExplodeAnimation(creature.world, x, y, 100));
			}));
		}
		
		private function getCandidate(caster:Creature, p:Point):MagicAction 
		{
			var other:Creature = caster.world.getCreature(caster.x + p.x, caster.y + p.y);
		
			if (other == null || !caster.doesHate(other) || !caster.canSee(other))
				return null;
				
			return new MagicAction(33, function(c:Creature):void {
				c.world.addAnimation(new ExplodeAnimation(c.world, c.x + p.x, c.y + p.y, 100));
			});
		}
	}
}