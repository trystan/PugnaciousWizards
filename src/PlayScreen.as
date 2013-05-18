package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	public class PlayScreen extends BaseScreen
	{
		public var game:Game;
		public var intervalTimeout:int = 0;
		
		public function PlayScreen() 
		{
			game = new Game();
			game.startGame();
			game.hero = new Player(2, 12);
			game.world.hero = game.hero;
			game.world.addCreature(game.hero);
			
			display(new WorldView(game));
			display(function(terminal:AsciiPanel):void {
				var help:String = "Hello there! Since this is your first turn, I'll explain some details. You control the @ symbol on the left of the screen. Your health, status, and magic are all on the right hand side of this screen. You are on a quest to find three pieces of an amulet hidden within this castle. You should first go through the door, it's the brownish thing to the right of your character. At any time, type [X] to examine your surroundings or [?] to see more help.";
				HelpSystem.notify(game.hero, "First turn", null, help);
				
				var x:int = 81;
				var y:int = 5;
				var hpColor:int = Color.lerp(Color.hsv(120, 90, 90), Color.hsv(0, 90, 90), Math.max(1, Math.min(game.hero.hp, 100)) / 100.0);
				
				terminal.write(Math.floor((game.hero.hp * 1.0 / game.hero.maximumHp) * 100) + "% health", x, y+=2, hpColor);
				
				y++;
				var room:Room = game.world.getRoom(game.hero.x, game.hero.y);
				
				if (game.hero.x < 0 && game.hero.y < 0)
					terminal.write("another dimension", x, y += 2);
				else if (room == null && (game.hero.x < 5 || game.hero.y < 5 || game.hero.x > 75 || game.hero.y > 75))
					terminal.write("outside the castle", x, y += 2);
				else if (room == null)
					terminal.write("in a doorway", x, y += 2);
				else
					terminal.write(("in a " + room.name.toLowerCase()).substr(0, 19), x, y += 2);
				
				terminal.write(game.hero.piecesOfAmulet + "/3 amulet pieces" , x, y += 2);
				
				var fg:int = game.hero.canCastMagic ? 0xffc0c0c0 : 0xff666666;
				
				y++;
				terminal.write("-- help --", x, y += 2);
				terminal.write("X. examine", x, y += 2);
				terminal.write("?. help", x, y += 2);
				
				y++;
				terminal.write("-- magic --", x, y += 2);
				
				var i:int = 1;
				for each (var spell:Magic in game.hero.magic)
					terminal.write(((i++) + ". " + spell.name).substr(0, 19), x, y += 2);
				
							
				if (game.hero.hp < 1)
					switchToScreen(new DefeatScreen(game));
				else if (game.hero.piecesOfAmulet == 3 && game.hero.x < 5)
					switchToScreen(new VictoryScreen(game));
			});
			
			bind("h,left", "move w", walk, -1,  0);
			bind("l,right", "move e", walk,  1,  0);
			bind("k,up", "move n", walk,  0, -1);
			bind("j,down", "move s", walk,  0,  1);
			bind("y", "move nw", walk, -1, -1);
			bind("u", "move ne", walk,  1, -1);
			bind("b", "move se", walk, -1,  1);
			bind("n", "move sw", walk,  1,  1);
			bind(".", "step", walk, 0, 0);
			bind("?", "help", enterScreen, new HelpScreen());
			bind("X", "examine", function():void {
				enterScreen(new ExamineScreen(game));
			});
			
			for (var i:int = 0; i < 9; i++)
			{
				bind((i+1) +"", "magic " + (i+1), cast, i);
			}
			
			endTurn();
		}
		
		public function cast(i:int):void
		{
			if (!game.hero.canCastMagic)
				return;
			
			if (game.hero.magic.length <= i)
				return;
			
			game.hero.magic[i].playerCast(game.hero);
		}
		
		public function walk(mx:int, my:int):void
		{
			game.hero.walk(mx, my);
			endTurn();
		}
		
		override protected function handleIntent(intent:String, behavior:Function):void 
		{
			if (game.hero.isFrozenCounter > 0)
				endTurn();
			else
				super.handleIntent(intent, behavior);
		}
		
		private function endTurn():void
		{
			game.endTurn();
		}
	}
}