package  
{
	import spells.*;
	
	public class Game 
	{
		public var fieldOfView:FieldOfView;
		public var world:World;
		public var hero:MagicUser;
		
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
			addScrolls();
		}
		
		public function startDemo():void
		{
			startGame();
			hero = new Hero(1, 30);
			world.hero = hero;
			world.addCreature(hero);
		}
		
		private function applyRoomThemes():void 
		{
			var themes:Array = [
				new RoomTheme_NoMagic(),
				new RoomTheme_A(),
				new RoomTheme_G(),
				new RoomTheme_Outside(),
				new RoomTheme_ArrowTowers(),
				new RoomTheme_ArrowWall(),
				new RoomTheme_CheckerTraps(),
				new RoomTheme_Empty()];
			
			var half:int = themes.length / 2;
			
			while (themes.length > half)
				themes.splice(Math.floor(Math.random() * themes.length), 1);
			
			var favored:RoomTheme = themes[Math.floor(Math.random() * themes.length)];
			
			for (var i:int = 0; i < 4; i++)
				themes.push(favored);
			
			var themesWaitingToBeApplied:Array = [
				new RoomTheme_Portal(),
				new RoomTheme_Portal()];
			
			while (Math.random() < 0.5)
				themesWaitingToBeApplied.push(new RoomTheme_Portal());
				
			while (themesWaitingToBeApplied.length < world.rooms.length)
				themesWaitingToBeApplied.push(themes[Math.floor(Math.random() * themes.length)]);
			
			for each (var room:Room in world.rooms)
			{
				var i:int = Math.floor(Math.random() * themesWaitingToBeApplied.length);
				
				themesWaitingToBeApplied[i].apply(world, room);
				themesWaitingToBeApplied.splice(i, 1);
			}
		}
		
		public function addScrolls()
		{
			var spellList:Array = [
				new HealFromBlood(),
				new BlindingFlash(),
				new FieryTeleport(),
				new IceBlink(),
				new BoneSplode(),
				new Inferno(),
				new TimedDeath(), ];
				
			while (spellList.length > 0)
			{
				var x:int = 5 + Math.floor(Math.random() * 7 * 9);
				var y:int = 5 + Math.floor(Math.random() * 7 * 9);
				
				if (!world.getTile(x, y).isWalkable || !world.getTile(x, y).allowsVision)
					continue;
					
				if (world.getItem(x, y) != null)
					continue;
					
				var i:int = Math.floor(Math.random() * spellList.length);
				var spell:Magic = spellList[i];
				spellList.splice(i, 1);
				
				world.addItem(new Scroll(x, y, spell));
			}
		}
	}
}