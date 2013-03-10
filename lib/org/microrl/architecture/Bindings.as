package org.microrl.architecture 
{
	public interface Bindings 
	{
		function get inputs():Array;
		
		function get intents():Array;
		
		function bindInput(input:String, intent:String):void;
		
		function bindIntent(intent:String, behavior:Function):void;
		
		function intentForInput(input:String):String;

		function behaviorForIntent(intent:String):Function;
		
		function copy():Bindings;
	}	
}