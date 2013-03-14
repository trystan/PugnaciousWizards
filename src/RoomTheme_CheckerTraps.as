package  
{
	import animation.Explosion;
	import effect.Fire;
	import flash.geom.Point;
	
	public class RoomTheme_CheckerTraps implements RoomTheme
	{
		public function apply(world:World, room:Room):void
		{
			if (room.hasTheme)
				return;
				
			room.hasTheme = true;
			room.name = "Empty room";
			
			var type:int = Math.random() < 0.5 ? 1 :0;
			var triggers:Array = [];
			
			for (var ox:int = 0; ox < 7; ox++)
			for (var oy:int = 0; oy < 7; oy++)
			{
				var x:int = room.x * 8 + 5 + ox;
				var y:int = room.y * 8 + 5 + oy;
				
				if ((x+y) % 2 == type)
					triggers.push(new Point(x, y));
			}
			
			world.addTriggerForEveryTurn(function():void {
				if (!room.contains(world.hero))
					return;
					
				for each (var p:Point in triggers)
				{
					if (world.getTile(p.x, p.y) == Tile.exposedTrap)
						continue;
						
					var c:Creature = world.getCreature(p.x, p.y);
					if (c == null)
						continue;
					
					world.setTile(p.x, p.y, Tile.exposedTrap)
					world.addAnimation(new Explosion(world, p.x, p.y, 49*4, new Fire()));
				}
			});
		}
	}
}