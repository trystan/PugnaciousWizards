package  
{
	public interface Magic 
	{
		function get description():String;
		function get name():String;
		
		function calculateAiBenefit(caster:Creature):MagicAction;
		
		function playerCast(caster:Creature):void;
		
		// function aiCast(caster:Creature):void;
	}
}