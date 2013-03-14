package animation
{
	import com.headchant.asciipanel.AsciiPanel;
	import effect.Effect;
	
	public class EverythingVisible extends AnimatedScreen 
	{
		public function EverythingVisible(creature:Creature, magicEffect:Effect) 
		{
			var fov:FieldOfView = new FieldOfView();
			
			fov.calculateVisibility(creature.x, creature.y, 13, function(vx:int, vy:int):Boolean {
				return creature.world.getTile(vx, vy).allowsVision;
			});
			
			display(function(terminal:AsciiPanel):void {
				for (var x:int = 0; x < 80; x++)
				for (var y:int = 0; y < 80; y++)
				{
					if (!fov.isVisibleNow(x, y))
						continue;
						
					terminal.write(" ", x, y, magicEffect.primaryColor, magicEffect.secondaryColor);
					
					magicEffect.applyPrimary(creature.world, x, y);
				}
			});
			
			bind(".", "animate", function():void {
				exitScreen();
			});
			
			animate(3);
		}
	}
}