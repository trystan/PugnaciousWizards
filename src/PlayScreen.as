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
				terminal.write(game.hero.hp + "% health", x, y+=2);
				terminal.write(game.hero.piecesOfAmulet + "/3 amulet pieces" , x, y+=2);
				
				y++;
				terminal.write("-- magic --", x, y+=2);
				terminal.write("1. blink", x, y+=2);
				terminal.write("2. missile", x, y+=2);
				terminal.write("3. heal", x, y+=2);
				terminal.write("4. explosion", x, y+=2);
				terminal.write("5. freeze", x, y+=2);
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
			
			bind("1", "magic 1", function ():void {
				game.hero.magic[0].playerCast(game.hero);
				step();
			});
			bind("2", "magic 2", function ():void {
				game.hero.magic[1].playerCast(game.hero);
				step();
			});
			bind("3", "magic 3", function ():void {
				game.hero.magic[2].playerCast(game.hero);
				step();
			});
			bind("4", "magic 4", function ():void {
				game.hero.magic[3].playerCast(game.hero);
				step();
			});
			bind("5", "magic 5", function ():void {
				game.hero.magic[4].playerCast(game.hero);
				step();
			});
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