package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class TargetVisibleTileScreen extends BaseScreen
	{
		private var x:int;
		private var y:int;
		private var world:World;
		private var targetX:int;
		private var targetY:int;
		private var fov:FieldOfView;
		private var callback:Function;
		
		public function TargetVisibleTileScreen(x:int, y:int, r:int, world:World, callback:Function) 
		{	
			this.x = x;
			this.y = y;
			this.world = world;
			this.targetX = x;
			this.targetY = y;
			this.fov = new FieldOfView();
			this.callback = callback;
			
			fov.calculateVisibility(x, y, r, function(wx:int, wy:int):Boolean {
				return world.getTile(wx, wy).allowsVision;
			});
			
			display(function(terminal:AsciiPanel):void {
				terminal.write("Where?", 2, 78);
				
				var t:Tile = world.getTile(targetX, targetY);
				var fg:int = isValidTarget() ? 0xffffff : 0xffffcccc;
				var bg:int = isValidTarget() ? t.bg : Color.lerp(0xffff0000, t.bg, 0.50);

				terminal.write("x", targetX, targetY, fg, bg);
			});
			
			bind("h,left", "move w", move, -1,  0);
			bind("l,right", "move e", move,  1,  0);
			bind("k,up", "move n", move,  0, -1);
			bind("j,down", "move s", move,  0,  1);
			bind("y", "move nw", move, -1, -1);
			bind("u", "move ne", move,  1, -1);
			bind("b", "move se", move,  1,  1);
			bind("n", "move sw", move, -1,  1);
			bind(".", "step", move, 0, 0);
			bind("enter", "done", doCallback);
			bind("escape", "exit", exitScreen);
		}
		
		private function move(mx:int, my:int):void
		{		
			targetX += mx;
			targetY += my;
		}
		
		private function doCallback():void
		{
			if (!isValidTarget())
				return;
				
			callback(targetX, targetY);
			exitScreen();
		}
		
		public function isValidTarget():Boolean
		{
			if (!fov.isVisibleNow(targetX, targetY))
				return false;
				
			if (!world.getTile(targetX, targetY).allowsVision)
				return false;
				
			return true;
		}
	}
}