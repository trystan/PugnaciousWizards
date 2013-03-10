package org.minispec
{
	import flash.utils.describeType;
	
	public class Specs
	{	
		private var results:SpecResults;
		
		public function run(results:SpecResults = null):void
		{
			this.results = results == null ? new SpecResults() : results;
			
			var description:XML = describeType(this);
			
			beforeAll();
			for each (var method:XML in description.method)
			{
				if (method.@declaredBy != description.@name)
					continue;
				
				try
				{
					this.results.begin(description.@name, method.@name);
					before();
					this[method.@name]();
				} 
				catch (e:Error)
				{
					this.results.fail(e.message);
				}
				finally
				{
					after();	
				}
			}
			afterAll();
		}

		protected function beforeAll():void
		{
		}
		
		protected function afterAll():void
		{
		}
		
		protected function before():void
		{
		}
		
		protected function after():void
		{
		}
		
		protected function expect(actual:*, condition:SpecCondition):void
		{
			condition.test(actual, results);
		}
		
		protected function equals(expected:*):Equals
		{
			return new Equals(expected);
		}
	}
}