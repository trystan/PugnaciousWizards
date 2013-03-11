package  
{
	public interface Magic 
	{
		function calculateAiBenefit(caster:Creature):MagicAction;
		
		function playerCast(caster:Creature):void;
		
		// function aiCast(caster:Creature):void;
	}
}