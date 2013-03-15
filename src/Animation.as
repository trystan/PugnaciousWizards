package  
{
	import com.headchant.asciipanel.AsciiPanel;
	public interface Animation
	{
		function get isDone():Boolean;
		function tick(terminal:AsciiPanel):void;
	}
}