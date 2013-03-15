package  
{
	import spells.BlindingFlash;
	import spells.BoneSplode;
	import spells.FieryTeleport;
	import spells.HealFromBlood;
	import spells.HealingBurst;
	import spells.IceBlink;
	import spells.Inferno;
	import spells.MagicMissile;
	
	public class MagicUser extends Creature
	{
		public var magic:Array = [
			new MagicMissile(),
			new HealingBurst(),
			new HealFromBlood(),
			new BlindingFlash(),
			new FieryTeleport(),
			new IceBlink(),
			new BoneSplode(),
			new Inferno(),
		];
			
		public function MagicUser(glyph:String, fg:int, x:int, y:int, name:String, description:String) 
		{
			super(glyph, fg, x, y, name, description);
			
			meleeAttack = 20;
			meleeDefence = 5;
			hp = 100;
			baseViewDistance = 12;
		}
		
		public function get canCastMagic():Boolean
		{
			return world.getRoom(x, y) == null || !world.getRoom(x, y).forbidMagic
		}
		
		public function aiCastSpell():Boolean
		{	
			if (!canCastMagic)
				return false;
				
			var actions:Array = [];
			for each (var m:Magic in magic)
			{
				actions.push(m.calculateAiBenefit(this))
			}
			
			var total:int = 0;
			for each (var potential:MagicAction in actions)
			{
				if (potential.benefit > 0)
					total += 100;
			}
			
			var rand:int = Math.random() * total;
			for each (var potential:MagicAction in actions)
			{
				rand -= Math.min(potential.benefit * 1.5, 100);
				if (rand < 0)
				{
					potential.action(this);
					return true;
				}
			}
			return false;
		}
	}
}