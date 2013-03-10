package org.microrl.architecture
{
	import flash.utils.Dictionary;
	
	/**
	 * Maps user input to intent and intent to behavior.
	 */
	public class BaseBindings implements Bindings
	{
		private var boundInputs:Dictionary;
		private var boundIntents:Dictionary;
		
		public function BaseBindings()
		{
			boundInputs = new Dictionary();
			boundIntents = new Dictionary();
		}
		
		public function get inputs():Array
		{
			var arr:Array = new Array();
			
			for (var key:String in boundInputs)
				arr.push(key);
				
			return arr;
		}
		
		public function get intents():Array
		{
			var arr:Array = new Array();
			
			for (var key:String in boundIntents)
				arr.push(key);
				
			return arr;
		}
		
		public function bindInput(input:String, intent:String):void
		{
			var lastWasEmpty:Boolean = false;
			for each (var token:String in input.split(","))
			{
				if (token.length == 0 && lastWasEmpty)
					boundInputs[","] = intent;
				else if (token.length > 0)
					boundInputs[token] = intent;
					
				lastWasEmpty = token.length == 0;
			}
		}
		
		public function bindIntent(intent:String, behavior:Function):void
		{
			boundIntents[intent] = behavior;
		}
		
		public function intentForInput(input:String):String
		{
			if (input == null)
				return null;
			else
				return boundInputs[input];
		}

		public function behaviorForIntent(intent:String):Function
		{
			if (intent == null)
				return null;
			else
				return boundIntents[intent];
		}
		
		public function copy():Bindings
		{
			var copy:BaseBindings = new BaseBindings();
			
			for (var input:String in boundInputs)
				copy.boundInputs[input] = boundInputs[input];
			
			for (var intent:String in boundIntents)
				copy.boundIntents[intent] = boundIntents[intent];
				
			return copy;
		}
	}
}