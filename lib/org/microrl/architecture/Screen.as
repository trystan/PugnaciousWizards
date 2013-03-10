package org.microrl.architecture
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * Something that handles user input and output.
	 */
	public interface Screen
	{	
		function handleKeyboardInput(keyboardEvent:KeyboardEvent):void;
		function handleMouseInput(eventType:String, mouseEvent:MouseEvent):void;
		function handleAsciiOutput(terminal:AsciiPanel):void;
	}
}