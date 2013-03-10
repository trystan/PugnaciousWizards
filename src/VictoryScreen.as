package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;

	public class VictoryScreen extends BaseScreen
	{
		public function VictoryScreen(game:Game) 
		{
			display(new WorldView(game));
			
			display(function (terminal:AsciiPanel):void {
				terminal.writeCenter("-- You've won! Press enter to begin --", 78);
			});
			
			bind("enter", "begin", function():void {
				switchToScreen(new PlayScreen());
			});
		}	
	}
}