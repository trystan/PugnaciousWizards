package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;

	public class HelpScreen extends BaseScreen
	{
		private var text:Array = [
			"Explore the castle, ",
			"    find the three amulet pieces, ",
			"        and escape to where you began.",
			"",
			"You are the @. Look out for guards (g) and archers (a).",
			"Wizards (w) use magic to guard the amulet pieces (*).",
			"",
			"   w       yku",
			"  a.d  or  h.l  to move",
			"   s       bjn",
			"",
			"press 1 through 9 to use magic",
			"    some magic, like blink, happens instantly",
			"    some magic, like freeze, needs to be aimed in a direction",
			"    some magic, like explode, needs to be aimed at a target",
			"",
			"press X to examine your surroundings",
			"",
			"press ? for this screen",
		];
		
		public function HelpScreen() 
		{
			display(function (terminal:AsciiPanel):void {
				var top:int = 40 - text.length - 3;
				var left:int = 20;
				var fg:int = 0xffffffff;
				var bg:int = 0xff101010;
				
				for (var x:int = -2; x < 62; x++)
				for (var y:int = 0; y < text.length * 2 + 6; y++)
				{
					terminal.write(" ", left + x, top + y, fg, bg);
				}
				
				y = top;
				for each (var line:String in text)
				{
					terminal.write(line, left, y += 2, fg, bg);
				}
				terminal.writeCenter("-- press any key to continue --", y += 3, fg, bg);
			});
		}	
		
		override protected function unhandledInput(input:String):void 
		{
			if (input.indexOf("Mouse") > -1)
				super.unhandledInput(input);
			else
				exitScreen();
		}
	}
}