package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class TargetVisibleTileScreen extends BaseScreen
	{
		private var targetX:int;
		private var targetY:int;
		private var fov:FieldOfView;
		private var callback:Function;
		
		public function TargetVisibleTileScreen(x:int, y:int, fov:FieldOfView, callback:Function) 
		{	
			this.targetX = x;
			this.targetY = y;
			this.fov = fov;
			this.callback = callback;
			
			display(function(terminal:AsciiPanel):void {
				terminal.write("Where?", 2, 78);
				terminal.write("x", targetX, targetY);
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
			if (!fov.isVisibleNow(targetX + mx, targetY + my))
				return;
				
			targetX += mx;
			targetY += my;
		}
		
		private function doCallback():void
		{
			callback(targetX, targetY);
			exitScreen();
		}
	}
}