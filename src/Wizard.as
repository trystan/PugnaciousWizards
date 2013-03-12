package  
{
	import flash.geom.Point;
	
	public class Wizard extends MagicUser
	{
		public var targetPoint:Point;
		public var pathToTarget:Array = [];
		
		public function Wizard(x:int, y:int)
		{
			super("w", Color.rgb(330, 90, 90), x, y);
			
			meleeAttack = 15;
			meleeDefence = 5;
			hp = 100;
		}
		
		override public function doesHate(other:Creature):Boolean
		{
			return other != null && other != this && (other is MagicUser || other is Skeleton); // includes wizards and hero
		}
		
		override public function teleportTo(nx:int, ny:int):void
		{
			pathToTarget = [];
			super.teleportTo(nx, ny);
		}
		
		override public function updateInternal():void
		{
			if (aiCastSpell())
				return;
			
			if (canSee(world.hero))
			{
				targetPoint = new Point(world.hero.x, world.hero.y);
				pathToTarget = AStar.pathTo(
						function(wx:int, wy:int):Boolean { return world.getTile(wx, wy).isWalkable; },
						new Point(x, y),
						targetPoint, 
						true);
			}
			
			if (pathToTarget != null && pathToTarget.length > 0);
			{
				var next:Point = pathToTarget.shift();
				if (next != null)
					walk(next.x - x, next.y - y);
			}
		}
	}
}