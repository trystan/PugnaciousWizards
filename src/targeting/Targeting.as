package targeting 
{
	public interface Targeting 
	{
		function calculateAiBenefit(caster:Creature):MagicAction;
		function playerCast(creature:Creature):void;		
	}
}