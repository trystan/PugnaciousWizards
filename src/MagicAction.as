package  
{
	public class MagicAction 
	{
		public var benefit:int;
		public var action:Function;
		
		public function MagicAction(benefit:int, action:Function) 
		{
			this.benefit = benefit;
			this.action = action;
		}
		
		public function execute(caster:Creature):void
		{
			action(caster);
		}
	}
}