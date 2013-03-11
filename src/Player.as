package  
{
	public class Player extends Creature
	{		
		public var piecesOfAmulet:int = 0;
		
		public var magic:Array = [
			new MagicSpell(new MagicBlink()),
			new MagicSpell(new MagicMissile()),
			new MagicSpell(new MagicHeal()),
			new MagicSpell(new MagicExplode()),
			new MagicSpell(new MagicFreeze())
		];
			
		public function Player(x:int, y:int) 
		{
			super("@", Color.hsv(0, 0, 90), x, y);
			
			meleeAttack = 20;
			meleeDefence = 5;
			hp = 100;
			viewDistance = 12;
		}
		
		override public function isEnemy(other:Creature):Boolean
		{
			return true;
		}
		
		override public function updateInternal():void
		{
			var itemHere:Item = world.getItem(x, y);
			if (itemHere is PieceOfAmulet)
			{
				piecesOfAmulet++;
				world.removeItem(itemHere);
			}
		}
	}
}