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
					intervalTimeout = setInterval(RL.instance.handleKeyboardEvent, 50, event);	
				}
				
				terminal.clear();
				
				var t:Tile;
				for (var x:int = 0; x < 80; x++)
				for (var y:int = 0; y < 80; y++)
				{
					t = world.getTile(x, y);
					terminal.write(t.glyph, x, y, t.fg, t.bg);
				}
				
				for each (var item:PileOfBones in world.items)
				{
					t = world.getTile(item.x, item.y);
					terminal.write(item.glyph, item.x, item.y, item.fg, t.bg);
				}
				
				for each (var creature:Creature in world.creatures)
				{
					t = world.getTile(creature.x, creature.y);
					terminal.write(creature.glyph, creature.x, creature.y, creature.fg, t.bg);
				}
				/*
				// show distance from starting room
				for each (var room:Room in world.rooms)
				{
					var x:int = room.x * 8 + 6;
					var y:int = room.y * 8 + 6;
					
					terminal.write(room.dist + "", x, y);
				}*/
				
				terminal.writeCenter("Pugnacious Wizards", 1);
				terminal.writeCenter("a 2013 7DRL by Trystan Spangler", 3);
			});
				
			bind(".", "step", function():void {
				if (hero.hp < 1)
					startDemo();
					
				world.update();
				
				while (world.animations.length > 0)
				{
					enterScreen(world.animations.shift());
				}
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
			
			for each (var room:Room in world.rooms)
			{
				if (Math.random() < 0.5)
					continue;
				
				var points:int = room.dist;
				
				while (points > 0)
				{
					var x:int = room.x * 8 + 5 + Math.floor(Math.random() * 7);
					var y:int = room.y * 8 + 5 + Math.floor(Math.random() * 7);	
					
					var t:int = Math.random();
					
					if (t < 0.20 && points > 12)
					{
						points -= 12;
						world.addCreature(new Knight(x, y));
					}
					else if (t < 0.40 && points > 6)
					{
						points -= 6;
						world.addCreature(new Archer(x, y));
					}
					else
					{
						points -= 4;
						world.addCreature(new Guard(x, y));
					}
				}
			}
		}
	}
}