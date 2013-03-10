package org.microrl.architecture 
{
	public class Util 
	{
		public static function callFunc(func:Function, args:Array):void
		{
			switch (args.length)
			{
				case 0: func(); break;
				case 1: func(args[0]); break;
				case 2: func(args[0], args[1]); break;
				case 3: func(args[0], args[1], args[2]); break;
				case 4: func(args[0], args[1], args[2], args[3]); break;
				case 5: func(args[0], args[1], args[2], args[3], args[4]); break;
				default: throw new Error("RL can only handle binding to functions with 5 or fewer parameters.");
			}
		}
	}
}