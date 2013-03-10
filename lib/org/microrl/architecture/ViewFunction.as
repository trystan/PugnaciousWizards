package org.microrl.architecture
{
	import com.headchant.asciipanel.AsciiPanel;
	
	/**
	 * Something that updates the screen by calling one function.
	 */
	public class ViewFunction implements View
	{
		private var func:Function;
		
		public function ViewFunction(func:Function) 
		{
			this.func = func;
		}
		
		public function viewOn(terminal:AsciiPanel):void
		{
			func(terminal);
		}
	}
}