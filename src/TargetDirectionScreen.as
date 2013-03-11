package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class TargetDirectionScreen extends BaseScreen
	{
		private var callback:Function;
		
		public function TargetDirectionScreen(callback:Function) 
		{	
			this.callback = callback;
			
			display(function(terminal:AsciiPanel):void {
				terminal.write("Which direction?", 2, 78);
			});
			
			bind("h,left", "move w", doCallback, -1,  0);
			bind("l,right", "move e", doCallback,  1,  0);
			bind("k,up", "move n", doCallback,  0, -1);
			bind("j,down", "move s", doCallback,  0,  1);
			bind("y", "move nw", doCallback, -1, -1);
			bind("u", "move ne", doCallback,  1, -1);
			bind("b", "move se", doCallback, -1,  1);
			bind("n", "move sw", doCallback,  1,  1);
			bind(".", "step", doCallback, 0, 0);
			bind("escape", "exit", exitScreen);
		}
		
		private function doCallback(x:int, y:int):void
		{
			callback(x, y);
			exitScreen();
		}
	}
}