package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.events.KeyboardEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
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
			game.hero = new Player(2, 40);
			game.world.addCreature(game.hero);
			step();
			
			display(new WorldView(game));
			display(function(terminal:AsciiPanel):void {
				var x:int = 81;
				var y:int = 5;
				var hpColor:int = Color.lerp(Color.hsv(120, 90, 90), Color.hsv(0, 90, 90), Math.max(1, Math.min(game.hero.hp, 100)) / 100.0);
				terminal.write(game.hero.hp + "% health", x, y+=2, hpColor);
				
				y++;
				var room:Room = game.world.getRoom(game.hero.x, game.hero.y);
				
				if (room == null && (game.hero.x < 5 || game.hero.y < 5 || game.hero.x > 75 || game.hero.y > 75))
					terminal.write("ouside the castle", x, y += 2);
				else if (room == null)
					terminal.write("in a doorway", x, y += 2);
				else
					terminal.write(("in a " + room.description.toLowerCase()).substr(0, 19), x, y += 2);
				
				terminal.write(game.hero.piecesOfAmulet + "/3 amulet pieces" , x, y += 2);
				
				var fg:int = game.hero.canCastMagic ? 0xffc0c0c0 : 0xff666666;
				
				terminal.write("-- magic --", x, y+=2);
				terminal.write("1. blink", x, y+=2, fg);
				terminal.write("2. missile", x, y+=2, fg);
				terminal.write("3. heal", x, y+=2, fg);
				terminal.write("4. explode", x, y+=2, fg);
				terminal.write("5. freeze", x, y+=2, fg);
				terminal.write("6. blind", x, y+=2, fg);
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
			
			for (var i:int = 0; i < game.hero.magic.length; i++)
			{
				bind((i+1) +"", "magic " + (i+1), cast, i);
			}
		}
		
		public function cast(i:int):void
		{
			if (!game.hero.canCastMagic)
				return;
				
			game.hero.magic[i].playerCast(game.hero);
			step();
		}
		
		public function walk(mx:int, my:int):void
		{
			game.hero.walk(mx, my);
			step();
		}
		
		override protected function handleIntent(intent:String, behavior:Function):void 
		{
			if (game.hero.isFrozenCounter > 0)
				step();
			else
				super.handleIntent(intent, behavior);
		}
		
		private function step():void
		{
			if (game.hero.hp < 1)
				switchToScreen(new DefeatScreen(game));
			else if (game.hero.piecesOfAmulet == 3 && game.hero.x < 5)
				switchToScreen(new VictoryScreen(game));
			else
				tick();
		}
		
		private function tick():void
		{
			while (game.world.animations.length > 0)
				enterScreen(game.world.animations.shift());
			
			game.world.update();
			game.fieldOfView.calculateVisibility(game.hero.x, game.hero.y, game.hero.viewDistance, function(vx:int, vy:int):Boolean {
				return game.world.getTile(vx, vy).allowsVision;
			});
			
			while (game.world.animations.length > 0)
				enterScreen(game.world.animations.shift());
		}
	}
}