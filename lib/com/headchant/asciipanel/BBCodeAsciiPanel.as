package com.headchant.asciipanel 
{
	import flash.utils.Dictionary;
	
	/**
	 * Supports the [color=RRGGBB] and [bg=RRGGBB] tags found on some BB Code capable forums.
	 * 
	 * http://forums.htmlhelp.com/index.php?index.php?s=&act=legends&CODE=bbcode
     * 
	 * Color codes can be RRGGBB, 0xRRGGBB, #RRGGBB, or a named color.
	 */
	public class BBCodeAsciiPanel extends AsciiPanel
	{
		public var namedColors:Object = {
			red:0xff0000,
			orange:0xe57200,
			yellow:0xffff00,
			green:0x00ff00,
			blue:0x0000ff,
			white:0xffffff,
			light:0xcccccc,
			gray:0x999999,
			dark:0x333333,
			black:0x000000
		};
		
		public function BBCodeAsciiPanel(widthInCharacters:int = 80, heightInCharacters:int = 24) {	
			super(widthInCharacters, heightInCharacters);
		}
		
		override public function write(string:String, x:int, y:int, fgcolor:uint = 0xC0C0C0, bgcolor:uint = 0x000000):void
		{
			var mode:int = 0;
			var writeX:int = x;
			var colorStack:Array = [];
			var bgStack:Array = [];
			
			for (var i:int = 0; i < string.length; i++)
			{
				var remainder:String = string.substr(i);
				var color:String;
				
				if (/^\[color=[^\]]*\]/i.test(remainder))
				{
					color = /^\[color=([^\]]*)\]/i.exec(remainder)[1];
					i += color.length + 7;
					colorStack.push(fgcolor);
					fgcolor = getColor(color);
				}
				else if (/^\[\/color\]/i.test(remainder))
				{
					i += 7;
					fgcolor = colorStack.pop();
				}
				else if (/^\[bg=[^\]]*\]/i.test(remainder))
				{
					color = /^\[bg=([^\]]*)\]/i.exec(remainder)[1];
					i += color.length + 4;
					bgStack.push(bgcolor);
					bgcolor = getColor(color);
				}
				else if (/^\[\/bg\]/i.test(remainder))
				{
					i += 4;
					bgcolor = bgStack.pop();
				}
				else
				{
					super.write(string.charAt(i), writeX++, y, fgcolor, bgcolor);
				}
			}
		}
		
		private function getColor(color:String):int
		{
			if (/0x....../i.test(color))
				return parseInt(color);
			else if (/#....../i.test(color))
				return parseInt("0x" + color.substr(1));
			else if (namedColors[color] != undefined)
				return namedColors[color];
			else if (/....../i.test(color))
				return parseInt("0x" + color);
			else if (!isNaN(parseInt(color)))
				return parseInt(color);
			else
				throw new ArgumentError("color '" + color + "' must be an int, rrggbb, 0xrrggbb, #rrggbb, or in the namedColors object");
		}
	}
}
