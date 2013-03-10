package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	import flash.events.KeyboardEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	public class IntroScreen extends BaseScreen 
	{
		private var world:World;
		private var hero:Hero;
		public var intervalTimeout:uint = 0;
		
		public function IntroScreen() 
		{
			startDemo();
			
			display(function(terminal:AsciiPanel):void {
				if (intervalTimeout == 0)
				{
					var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 46, 190);
					intervalTimeout = setInterval(RL.instance.handleKeyboardEvent, 100, event);	
				}
				
				terminal.clear();
				
				for (var x:int = 0; x < 80; x++)
				for (var y:int = 0; y < 80; y++)
				{
					var t:Tile = world.getTile(x, y);
					terminal.write(t.glyph, x, y, t.fg, t.bg);
				}
				
				for each (var creature:Creature in world.creatures)
				{
					var t:Tile = world.getTile(creature.x, creature.y);
					terminal.write(creature.glyph, creature.x, creature.y, creature.fg, t.bg);
				}
				
				terminal.writeCenter("Pugnacious Wizards", 1);
				terminal.writeCenter("a 2013 7DRL by Trystan Spangler", 3);
			});
				
			bind(".", "step", function():void {
				if (hero.hp < 1)
					startDemo();
					
				world.update();
			});
			
			bind("enter", "start", function():void {
				clearInterval(intervalTimeout);
			});
		}
		
		private function startDemo():void
		{
			world = new World();
			hero = new Hero(1, 30);
			world.addCreature(hero);
			
			for (var i:int = 0; i < 30; i++)
			{
				var x:int = Math.floor(Math.random() * 8 * 9) + 5;
				var y:int = Math.floor(Math.random() * 8 * 9) + 5;
				
				if (world.getTile(x, y).isWalkable)
					world.addCreature(new Guard(x, y));
			}
		}
	}
}