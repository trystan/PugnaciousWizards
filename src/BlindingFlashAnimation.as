package  
{
	import com.headchant.asciipanel.AsciiPanel;
	public class BlindingFlashAnimation extends AnimatedScreen 
	{
		public function BlindingFlashAnimation(creature:Creature) 
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
						
					terminal.write(" ", x, y, 0xffffffff, 0xffffffff);
					
					var c:Creature = creature.world.getCreature(x, y);
					if (c == null)
						continue;
					
					if (c.isBlindCounter > 0)
						continue;
					
					c.isBlindCounter = 12;
				}
			});
			
			bind(".", "animate", function():void {
				exitScreen();
			});
			
			animate(3);
		}
	}
}