package effects 
{
	public interface Effect 
	{
		function get primaryColor():int;
		function get secondaryColor():int;
		function applyPrimary(world:World, x:int, y:int):void;
		function applySecondary(world:World, x:int, y:int):void;
	}
}