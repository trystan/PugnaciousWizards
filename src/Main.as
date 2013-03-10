package 
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.microrl.architecture.RL;
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			var terminal:AsciiPanel = new AsciiPanel(80, 80);
			terminal.useRasterFont(AsciiPanel.codePage437_8x8, 8, 8);
			
			addChild(new RL(new IntroScreen(), terminal));
		}
	}
}