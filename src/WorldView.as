package  
{
	import org.microrl.architecture.View;
	import com.headchant.asciipanel.AsciiPanel;
	
	public class WorldView implements View
	{
		public var game:Game;
		
		public function WorldView(game:Game) 
		{
			this.game = game;
		}	
		
		public function viewOn(terminal:AsciiPanel):void
		{
			terminal.clear();
			
			var t:Tile;
			for (var x:int = 0; x < 80; x++)
			for (var y:int = 0; y < 80; y++)
			{
				var blood:int = game.world.getBlood(x, y);
				if (game.fieldOfView.isVisibleNow(x, y))
				{
					t = game.world.getTile(x, y);
					if (blood == 0)
						terminal.write(t.glyph, x, y, t.fg, t.bg);
					else
						terminal.write(t.glyph, x, y, Color.lerp(t.fg, Color.blood, 1 - blood / 10), Color.lerp(t.bg, Color.blood, 1 - blood / 10));
				}
				else if (game.fieldOfView.wasVisible(x, y))
				{
					var memoryFg:int = Color.hsv(250, 100, 20);
					var memoryBg:int = Color.hsv(250, 100, 5);
					t = game.world.getTile(x, y);
					if (blood == 0)
						terminal.write(t.glyph, x, y, Color.lerp(t.fg, memoryFg, 0.33), Color.lerp(t.bg, memoryBg, 0.33));
					else
						terminal.write(t.glyph, x, y, Color.lerp(Color.lerp(t.fg, Color.blood, 1 - blood / 10), memoryFg, 0.33), Color.lerp(Color.lerp(t.bg, Color.blood, 1 - blood / 10), memoryBg, 0.33));
				}
			}
			
			for each (var item:Item in game.world.items)
			{
				if (game.fieldOfView.isVisibleNow(item.x, item.y))
				{
					var blood:int = game.world.getBlood(item.x, item.y);
					t = game.world.getTile(item.x, item.y);
					if (blood == 0)
						terminal.write(item.glyph, item.x, item.y, item.fg, t.bg);
					else
						terminal.write(item.glyph, item.x, item.y, item.fg, Color.lerp(t.bg, Color.blood, 1 - blood / 10));
				}
			}
			
			for each (var creature:Creature in game.world.creatures)
			{
				if (game.fieldOfView.isVisibleNow(creature.x, creature.y))
				{
					var blood:int = game.world.getBlood(creature.x, creature.y);
					t = game.world.getTile(creature.x, creature.y);
					if (blood == 0)
						terminal.write(creature.glyph, creature.x, creature.y, creature.color, t.bg);
					else
						terminal.write(creature.glyph, creature.x, creature.y, creature.color, Color.lerp(t.bg, Color.blood, 1 - blood / 10));
				}
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
		}
	}
}