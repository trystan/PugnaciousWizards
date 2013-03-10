package org.microrl.architecture
{
	import com.headchant.asciipanel.AsciiPanel;
	
	/**
	 * Represents something that updates the view. Health bar, text, monster, etc.
	 */
	public interface View
	{
		function viewOn(terminal:AsciiPanel):void;
	}
}