package delivery
{
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Effect;
	
	public class Instant implements Animation
	{
		public var world:World;
		public var x:int;
		public var y:int;
		public var magicEffect:Effect;
		
		public function Instant(world:World, x:int, y:int, magicEffect:Effect) 
		{
			this.world = world;
			this.x = x;
			this.y = y;
			this.magicEffect = magicEffect;
		}
		
		public function get isDone():Boolean 
		{
			return true;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			magicEffect.applyPrimary(world, x, y);
		}
	}
}