package org.minispec
{
	public class SpecResults 
	{
		private var currentClassName:String;
		private var currentFunctionName:String;
		
		public function begin(className:String, functionName:String):void
		{
			currentClassName = className;
			currentFunctionName = functionName;
		}
		
		public function pass(details:String):void
		{
		}
		
		public function fail(details:String):void
		{
			trace(currentClassName + " " + currentFunctionName + " FAILED: " + details);
		}
	}
}