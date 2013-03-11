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
				terminal.writeCenter(game.hero.hp + "% health", 4);
				terminal.writeCenter("You need " + (3 - game.hero.piecesOfAmulet) + " more peices of the amulet.", 78);
			});
			
			bind("h,left", "move w", walk, -1,  0);
			bind("l,right", "move e", walk,  1,  0);
			bind("k,up", "move n", walk,  0, -1);
			bind("j,down", "move s", walk,  0,  1);
			bind("y", "move nw", walk, -1, -1);
			bind("u", "move ne", walk,  1, -1);
			bind("b", "move se", walk,  1,  1);
			bind("n", "move sw", walk, -1,  1);
			bind(".", "step", walk, 0, 0);
			
			bind("1", "magic 1", function ():void {
				new MagicBlink().apply(game.hero);
				step();
			});
			bind("2", "magic 2", function ():void {
				new MagicMissile().apply(game.hero);
			});
			bind("3", "magic 3", function ():void {
				new MagicHeal().apply(game.hero);
				step();
			});
		}
		
		public function walk(mx:int, my:int):void
		{
			game.hero.walk(mx, my);
			step();
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
			{
				enterScreen(game.world.animations.shift());
			}
			
			game.world.update();
			game.fieldOfView.calculateVisibility(game.hero.x, game.hero.y, 9, function(vx:int, vy:int):Boolean {
				return game.world.getTile(vx, vy).allowsVision;
			});
			
			while (game.world.animations.length > 0)
			{
				enterScreen(game.world.animations.shift());
				
				// RL.instance.handleKeyboardEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 46, 190));
			}
		}
	}
}