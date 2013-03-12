package  
{
	public class Game 
	{
		public var fieldOfView:FieldOfView;
		public var world:World;
		public var hero:Player;
		
		public function Game() 
		{
			
		}
		
		public function startGame():void
		{
			fieldOfView = new FieldOfView();
			world = new World();
			
			var maxDistance:int = 0;
			for each (var room:Room in world.rooms)
			{
				maxDistance = Math.max(maxDistance, room.dist);
				
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
			
			var candidates:Array = world.rooms.filter(function (value:Room, index:int, array:Array):Boolean {
				return value.dist > maxDistance / 2;
			});
			
			if (candidates.length < 3)
			{
				startDemo();
			}
			else
			{
				for (var i:int = 0; i < 3; i++)
				{
					var room:Room = candidates[Math.floor(Math.random() * candidates.length)];
					
					candidates.splice(candidates.indexOf(room), 1);
					
					var x:int = room.x * 8 + 5 + 3;
					var y:int = room.y * 8 + 5 + 3;
					
					world.addItem(new PieceOfAmulet(x, y));
					world.addCreature(new Wizard(x, y - 1));
				}
			}
			// world.addCreature(new Wizard(2, 40));
		}
		
		public function startDemo():void
		{
			startGame();
			hero = new Hero(1, 30);
			world.addCreature(hero);
		}
	}
}