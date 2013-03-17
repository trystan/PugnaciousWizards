package  
{
	import delivery.EverythingVisibleFrom;
	import delivery.Explosion;
	import effects.MagicDamage;
	import effects.Heal;
	import traps.Trap;
	import triggers.CreatureAtLocation;
	import triggers.Trigger;
	import effects.Blind;
	import effects.Fire;
	import effects.Ice;
	import flash.geom.Point;
	
	public class RoomTheme_FloorTraps implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
			
			var patternPredicates:Array = [
				checker1,
				checker2,
				row1,
				row2,
				column1,
				column2,
				mainPath,
				alternatePaths,
			];
			
			var patternPredicate:Function = patternPredicates[Math.floor(Math.random() * patternPredicates.length)];
			var trapType:int = Math.random() * 4;
			var trapList:Array = [];
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				if (patternPredicate(x, y))
				{
					switch (trapType)
					{
						case 0:
							trapList.push(new Trap(
												new CreatureAtLocation(room, [new Point(x, y)]),
												new Explosion(world, x, y, 49, new Fire(5))));
							break;
						case 1:
							trapList.push(new Trap(
												new CreatureAtLocation(room, [new Point(x, y)]),
												new Explosion(world, x, y, 49, new MagicDamage(2))));
							break;
						case 2:
							trapList.push(new Trap(
												new CreatureAtLocation(room, [new Point(x, y)]),
												new Explosion(world, x, y, 49 / 2, new Blind())));
							break;
						case 4:
							trapList.push(new Trap(
												new CreatureAtLocation(room, [new Point(x, y)]),
												new Explosion(world, x, y, 49 / 2, new Ice())));
							break;
					}
				}
			}
			
			world.addTriggerForEveryTurn(function():void {
				for each (var trap:Trap in trapList)
					trap.check(world);
			});
			
			addBlood(world, room, trapList.length);
			
			if (Math.random() < 0.75)
				addPillar(world, room);
		}
		
		public function addPillar(world:World, room:Room):void
		{
			var x:int = room.x * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			var y:int = room.y * 8 + 5 + Math.floor(Math.random() * 5) + 1;
			
			world.setTile(x, y, Tile.wall);
			
			if (Math.random() < 0.2)
				addPillar(world, room);
		}
		
		public function addBlood(world:World, room:Room, amount:int):void
		{
			var max:int = world.maxBloodPerTile * 49;
			var total:int = max * amount / 100.0;
			for (var i:int = 0; i < total; i++)
			{
				var x:int = room.x * 8 + 4 + Math.floor(Math.random() * 9);
				var y:int = room.y * 8 + 4 + Math.floor(Math.random() * 9);
				
				world.addBlood(x, y);
			}
		}
		
		public function checker1(x:int, y:int):Boolean
		{
			return (x + y) % 2 == 0;
		}
		
		public function checker2(x:int, y:int):Boolean
		{
			return (x + y) % 2 == 0;
		}
		
		public function row1(x:int, y:int):Boolean
		{
			return y % 2 == 0;
		}
		
		public function row2(x:int, y:int):Boolean
		{
			return y % 2 == 1;
		}
		
		public function column1(x:int, y:int):Boolean
		{
			return x % 2 == 0;
		}
		
		public function column2(x:int, y:int):Boolean
		{
			return x % 2 == 1;
		}
		
		public function mainPath(x:int, y:int):Boolean
		{
			x -= 8;
			y -= 8;
			
			return x % 8 == 0 || y % 8 == 0;
		}
		
		public function alternatePaths(x:int, y:int):Boolean
		{
			return !mainPath(x, y);
		}
	}
}