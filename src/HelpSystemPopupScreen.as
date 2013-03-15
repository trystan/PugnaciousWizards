package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;

	public class HelpSystemPopupScreen extends BaseScreen
	{
		private var text:Array = [];
		
		public function HelpSystemPopupScreen(event:String, details:String)
		{
			text = [event, ""];
			details = "   " + details;
			
			while (details.length > 60)
			{
				var i:int = 60;
				while (details.charAt(i) != " ")
					i--;
					
				text.push(details.substr(0, i));
				details = details.substr(i+1);
			}
			text.push(details);
			
			display(function (terminal:AsciiPanel):void {
				var top:int = 40 - text.length - 3;
				var left:int = 20;
				var fg:int = 0xffffffff;
				var bg:int = 0xff101010;
				
				for (var x:int = -2; x < 62; x++)
				for (var y:int = 0; y < text.length * 2 + 8; y++)
				{
					terminal.write(" ", left + x, top + y, fg, bg);
				}
				
				y = top;
				for each (var line:String in text)
				{
					terminal.write(line, left, y += 2, fg, bg);
				}
				terminal.writeCenter("-- press escape to cancel these notifications --", y += 3, fg, bg);
				terminal.writeCenter("-- press enter to continue with notifications --", y += 2, fg, bg);
			});
			
			bind("escape", "quit", function():void {
				HelpSystem.enabled = false;
				exitScreen();
			});
			bind("enter", "continue", exitScreen);
		}
	}
}