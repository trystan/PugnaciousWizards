package  
{
	import flash.geom.Point;
	import spells.*;
	
	public class Wizard extends MagicUser
	{
		public var targetPoint:Point;
		public var pathToTarget:Array = [];
		
		public function Wizard(x:int, y:int)
		{
			super("w", Color.rgb(330, 90, 90), x, y, "wizard",
				"Even though they wear only robes and don't have any weapons, wizards are dangerously unpredictable and can cause all kinds of trouble with their assortment of spells.");
			
			meleeAttack = 5;
			hp = 60;
			maximumHp = 60;
			
			var candidates:Array = [
				new MagicMissile(),
				new HealAndBlind(),
				new FieryTeleport(),
				new HealFromBlood(),
				new BlindingFlash(),
				new IceBlink(),
				new BoneSplode(),
				new Inferno(),
				new TimedDeath(),
				new PullAndFreeze(),
				new HealingBurst()];
			
			this.magic = [];
			
			for (var i:int = 0; i < 5; i++)
			{
				var index:int = Math.random() * candidates.length;
				magic.push(candidates[index]);
				candidates.splice(index, 1);
			}
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
			
			if (isBlind)
			{
				pathToTarget = [];
				wander();
				return;
			}
			
			if (canSee(world.hero))
			{
				targetPoint = new Point(world.hero.x, world.hero.y);
				pathToTarget = AStar.pathTo(
						function(wx:int, wy:int):Boolean { return world.getTile(wx, wy).isWalkable; },
						new Point(x, y),
						targetPoint, 
						true);
			}
			
			if (pathToTarget != null && pathToTarget.length > 0)
			{
				var next:Point = pathToTarget.shift();
				if (next != null)
					walk(next.x - x, next.y - y);
			}
		}
	}
}