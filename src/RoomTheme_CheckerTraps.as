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
	
	public class RoomTheme_CheckerTraps implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
			
			var trapType:int = Math.random() * 3;
			var type:int = Math.random() < 0.5 ? 1 :0;
			var trapList:Array = [];
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				if ((x + y) % 2 == type)
				{
					if (Math.random() < 0.05)
					{
						trapList.push(new Trap(
											new CreatureAtLocation(room, [new Point(x, y)]),
											new Explosion(world, x, y, 49, new Heal(2))));
					}
					else
					{
						switch (trapType)
						{
							case 0:
								trapList.push(new Trap(
													new CreatureAtLocation(room, [new Point(x, y)]),
													new Explosion(world, x, y, 49 * 4, new Fire())));
								break;
							case 1:
								trapList.push(new Trap(
													new CreatureAtLocation(room, [new Point(x, y)]),
													new Explosion(world, x, y, 49, new MagicDamage(2))));
								break;
							case 2:
								trapList.push(new Trap(
													new CreatureAtLocation(room, [new Point(x, y)]),
													new EverythingVisibleFrom(world, x, y, 5, new Blind())));
								break;
						}
					}
				}
			}
			
			world.addTriggerForEveryTurn(function():void {
				for each (var trap:Trap in trapList)
					trap.check(world);
			});
			
			addBlood(world, room, 25);
			
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
	}
}