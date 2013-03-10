package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import flash.geom.Point;
	import org.microrl.architecture.BaseScreen;
	import org.microrl.architecture.RL;
	
	import flash.events.KeyboardEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	public class IntroScreen extends BaseScreen 
	{
		private var game:Game;
		public var intervalTimeout:uint = 0;
		
		public function IntroScreen() 
		{
			game = new Game();
			game.startDemo();
			
			display(function(terminal:AsciiPanel):void {
				if (intervalTimeout == 0)
					BeginNormalTime();
			});
			
			display(new WorldView(game));
				
			display(function(terminal:AsciiPanel):void {
				terminal.writeCenter("a 2013 7DRL by Trystan Spangler", 3);
				terminal.writeCenter("-- press enter to begin --", 78);
			});
			
			bind(".", "step", function():void {
				if (game.hero.hp < 1)
					game.startDemo();
				else if (game.hero.piecesOfAmulet == 3 && game.hero.x < 5)
					game.startDemo();
					
				game.world.update();
				game.fieldOfView.calculateVisibility(game.hero.x, game.hero.y, 9, function(vx:int, vy:int):Boolean {
					return game.world.getTile(vx, vy).allowsVision;
				});
				
				
				if (game.world.animations.length > 0)
				{
					BeginQuickTime();
					while (game.world.animations.length > 0)
					{
						enterScreen(game.world.animations.shift());
					}
					BeginNormalTime();
				}
			});
			
			bind("enter", "start", function():void {
				clearInterval(intervalTimeout);
				switchToScreen(new PlayScreen());
			});
		}
		
		private function BeginNormalTime():void 
		{
			clearInterval(intervalTimeout);
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 46, 190);
			intervalTimeout = setInterval(RL.instance.handleKeyboardEvent, 1000 / 10, event);
		}
		
		private function BeginQuickTime():void 
		{
			clearInterval(intervalTimeout);
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 46, 190);
			intervalTimeout = setInterval(RL.instance.handleKeyboardEvent, 10, event);
		}
	}
}