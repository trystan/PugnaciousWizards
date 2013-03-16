package  
{
	import spells.*;
	
	public class Player extends MagicUser
	{	
		public function Player(x:int, y:int) 
		{
			super("@", Color.hsv(0, 0, 90), x, y, "you", null);
			
			meleeAttack = 10;
			hp = 100;
			maximumHp = 100;
			baseViewDistance = 12;
			this.magic = [
				new MagicMissile(),
				new FieryTeleport()];
		}
		
		override public function doesHate(other:Creature):Boolean
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
			else if (itemHere is Scroll)
			{
				if (magic.length < 9)
				{
					magic.push((itemHere as Scroll).spell);
					world.removeItem(itemHere);
				}
			}
		}
	}
}