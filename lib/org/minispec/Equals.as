package org.minispec
{
	public class Equals implements SpecCondition 
	{
		private var expected:*;
		public function Equals(expected:*) 
		{
			this.expected = expected;
		}
		public function test(actual:*, results:SpecResults):void 
		{
			if (actual == expected)
				results.pass("expected " + expected + " and is " + actual + ".");
			else
				results.fail("expected " + expected + " but is " + actual + ".");
		}
	}
}