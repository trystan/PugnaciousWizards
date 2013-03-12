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
					
					if (points > 8 && Math.random())
					{
						points -= 8;
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
					
					new RoomTheme_Amulet().apply(world, room);
				}
			}
			
			applyRoomThemes();
		}
		
		public function startDemo():void
		{
			startGame();
			hero = new Hero(1, 30);
			world.addCreature(hero);
		}
		
		private function applyRoomThemes():void 
		{
			var themes:Array = [
				new RoomTheme_NoMagic(),
				new RoomTheme_A(),
				new RoomTheme_G(),
				new RoomTheme_Pillars(),
				new RoomTheme_Bloody(),
				new RoomTheme_Bones(),
				new RoomTheme_Outside(),
				new RoomTheme_ArrowTowers(),
				new RoomTheme_ArrowWall(),
				new RoomTheme_CheckerTraps()];
			
			themes.splice(Math.floor(Math.random() * themes.length), 1);
			themes.splice(Math.floor(Math.random() * themes.length), 1);
			
			var favored:RoomTheme = themes[Math.floor(Math.random() * themes.length)];
			var amount:int = themes.length - 1;
			
			while (themes.length < amount * 2)
				themes.push(favored);
				
			for each (var room:Room in world.rooms)
			{
				if (Math.random() < 0.75)
					themes[Math.floor(Math.random() * themes.length)].apply(world, room);
			}
		}
	}
}