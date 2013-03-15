package traps 
{
	import com.headchant.asciipanel.AsciiPanel;
	import delivery.Composite;
	import triggers.Trigger;
	
	public class Trap 
	{
		public var trigger:Trigger;
		public var action:Animation;
		
		public function Trap(trigger:Trigger, action:Animation) 
		{
			this.trigger = trigger;
			this.action = action;
		}
		
		public function check(world:World):void
		{
			if (!trigger.check(world))
				return;
			
			world.addAnimation(action); 
		}
	}
}