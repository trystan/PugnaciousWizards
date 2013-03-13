package  
{
	import com.headchant.asciipanel.AsciiPanel;
	import org.microrl.architecture.BaseScreen;

	public class ExamineScreen extends BaseScreen
	{
		private var lookX:int;
		private var lookY:int;
		
		public function ExamineScreen(game:Game) 
		{
			lookX = game.hero.x;
			lookY = game.hero.y;
			
			display(function (terminal:AsciiPanel):void {
				var text:String = "";
				
				if (lookX < 80)
				{
					var tileName:String = game.fieldOfView.isUnknown(lookX, lookY) ? "unknown" : game.world.getTile(lookX, lookY).name;
					var i:Item = game.fieldOfView.isVisibleNow(lookX, lookY) ? game.world.getItem(lookX, lookY) : null;
					var itemName:String = i == null ? null : i.name;
					var c:Creature = game.fieldOfView.isVisibleNow(lookX, lookY) ? game.world.getCreature(lookX, lookY) : null;
					var creatureName:String = c == null ? null : c.name;
					
					
					text = "";
					if (creatureName != null)
						text += creatureName + " ";
				
					if (c != null && i == null)
						text += "standing on ";
					if (c != null && i != null)
						text += "standing over ";
						
					if (itemName != null)
						text += itemName + " on ";
					
					if (tileName.length > 2 && tileName.substr(0, 2) == "a ")
					{
						text += "a ";
						tileName = tileName.substr(2);
					}
					else if (tileName.length > 3 && tileName.substr(0, 3) == "an ")
					{
						text += "an ";
						tileName = tileName.substr(3);
					}
						
					var blood:int = game.world.getBlood(lookX, lookY);
					blood = Math.floor(blood / game.world.maxBloodPerTile * 4);
					if (blood == 1)
						text += "blood splattered ";
					if (blood == 2)
						text += "bloody ";
					if (blood == 3)
						text += "blood soaked ";
					
					text += tileName;
					
					var room:Room = game.world.getRoom(lookX, lookY);
					if (room != null && !game.fieldOfView.isUnknown(lookX, lookY))
						text += " in " + room.name;
						
					text = text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();
				}
				
				var x:int = Math.max(0, Math.min(lookX - text.length / 2 + 1, 80 - text.length));
				var y:int = lookY - 3;
				
				if (y < 0)
					y = 0;
					
				var fg:int = 0xffffffff;
				var bg:int = 0xff101010;
				
				if (lookY > 0 && lookX > 0)
					terminal.write(String.fromCharCode(201), lookX - 1, lookY - 1, fg, bg);
				if (lookY > 0)
					terminal.write(String.fromCharCode(205), lookX - 0, lookY - 1, fg, bg);
				if (lookY > 0 && lookX < 99)
					terminal.write(String.fromCharCode(187), lookX + 1, lookY - 1, fg, bg);
				
				if (lookX > 0)
					terminal.write(String.fromCharCode(186), lookX - 1, lookY, fg, bg);
				if (lookX < 99)
					terminal.write(String.fromCharCode(186), lookX + 1, lookY, fg, bg);
				
				if (lookY < 79 && lookX > 0)
					terminal.write(String.fromCharCode(200), lookX - 1, lookY + 1, fg, bg);
				if (lookY < 79)
					terminal.write(String.fromCharCode(205), lookX - 0, lookY + 1, fg, bg);
				if (lookY < 79 && lookX < 99)
					terminal.write(String.fromCharCode(188), lookX + 1, lookY + 1, fg, bg);
				
				terminal.write(text, x, y, 0xffc0c0c0);
			});
			
			bind("h,left", "move w", move, -1,  0);
			bind("l,right", "move e", move,  1,  0);
			bind("k,up", "move n", move,  0, -1);
			bind("j,down", "move s", move,  0,  1);
			bind("y", "move nw", move, -1, -1);
			bind("u", "move ne", move,  1, -1);
			bind("b", "move se", move, -1,  1);
			bind("n", "move sw", move,  1,  1);
			bind("MouseMove", "look", function ():void {
				lookX = lastMouseEvent.localX / 8;
				lookY = lastMouseEvent.localY / 8;
			});
		}
		
		public function move(mx:int, my:int):void
		{
			lookX = Math.max(0, Math.min(lookX + mx, 99));
			lookY = Math.max(0, Math.min(lookY + my, 79));
		}
		
		override protected function unhandledInput(input:String):void 
		{
			exitScreen();
			super.unhandledInput(input);
		}
	}
}