package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;

	public class DefeatScreen extends BaseScreen
	{
		public function DefeatScreen(game:Game) 
		{
			display(new WorldView(game));
			
			display(function (terminal:AsciiPanel):void {
				terminal.writeCenter("-- You have died. Press enter to begin --", 78);
			});
			
			bind("enter", "begin", function():void {
				switchToScreen(new PlayScreen());
			});
		}	
	}
}