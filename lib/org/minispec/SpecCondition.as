package org.minispec
{
	public interface SpecCondition 
	{
		function test(actual:*, results:SpecResults):void;
	}
}