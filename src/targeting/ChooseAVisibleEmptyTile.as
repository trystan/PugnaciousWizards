package targeting 
{
	import flash.geom.Point;
	import org.microrl.architecture.RL;
	
	public class ChooseAVisibleEmptyTile implements Targeting
	{
		private var minDistance:int;
		private var maxDistance:int;
		public var castAtLocationCallback:Function;
		
		public function ChooseAVisibleEmptyTile(minDistance:int, maxDistance:int, castAtLocationCallback:Function):void
		{
			this.minDistance = minDistance;
			this.maxDistance = maxDistance;
			this.castAtLocationCallback = castAtLocationCallback;
		}
		
		private static var points:Array = null;
		public function calculateAiBenefit(caster:Creature):MagicAction
		{
			if (points == null)
			{
				points = [];
				for (var radius:int = minDistance; radius < maxDistance; radius++)
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
				if (!caster.canSeeLocation(p.x, p.y))
					continue;
					
				var candidate:MagicAction = getCandidate(caster, p);
				if (candidate != null)
					candidates.push(candidate);
			}
			
			if (candidates.length > 0)
				return candidates[Math.floor(Math.random() * candidates.length)];
				
			return new MagicAction(0, function(c:Creature):void {
			});
		}
		
		private function getCandidate(caster:Creature, p:Point):MagicAction 
		{
			if (!(caster is Hero))
				return null;
				
			var other:Creature = caster.world.getCreature(caster.x + p.x, caster.y + p.y);
		
			if (other != null)
				return null;
				
			return new MagicAction(20, function(c:Creature):void {
				c.world.addAnimation(castAtLocationCallback(caster.world, c.x + p.x, c.y + p.y));
			});
		}
		
		public function playerCast(creature:Creature):void
		{
			RL.enterScreen(new TargetVisibleTileScreen(creature.x, creature.y, creature.viewDistance, creature.world, function(x:int, y:int):void {
				creature.world.addAnimation(castAtLocationCallback(creature.world, x, y), Game.current.endTurn);
			}));
		}
	}
}