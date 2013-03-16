package  
{
	import delivery.Projectile;
	import com.headchant.asciipanel.AsciiPanel;
	import effects.Fire;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class RotatingTowersAnimation implements Animation
	{
		public var world:World;
		public var points:Array = [];
		
		public function RotatingTowersAnimation(world:World, points:Array) 
		{
			this.world = world;
			this.points = points;
		}
		
		public function get isDone():Boolean 
		{
			return true;
		}
		
		public function tick(terminal:AsciiPanel):void 
		{
			for each (var p:Point in points)
			{
				var t:Tile = world.getTile(p.x, p.y);
				
				switch (t) {
					case Tile.rotatingTower1:
						world.setTile(p.x, p.y, Tile.rotatingTower2);
						world.addAnimation(new Projectile(world, p.x, p.y, -1,  0, 7, new Fire(50)));
						world.addAnimation(new Projectile(world, p.x, p.y,  1,  0, 7, new Fire(50)));
						break;
					case Tile.rotatingTower2:
						world.setTile(p.x, p.y, Tile.rotatingTower3);
						world.addAnimation(new Projectile(world, p.x, p.y, -1, -1, 7, new Fire(50)));
						world.addAnimation(new Projectile(world, p.x, p.y,  1,  1, 7, new Fire(50)));
						break
					case Tile.rotatingTower3:
						world.setTile(p.x, p.y, Tile.rotatingTower4);
						world.addAnimation(new Projectile(world, p.x, p.y,  0, -1, 7, new Fire(50)));
						world.addAnimation(new Projectile(world, p.x, p.y,  0,  1, 7, new Fire(50)));
						break;
					case Tile.rotatingTower4:
						world.setTile(p.x, p.y, Tile.rotatingTower1);
						world.addAnimation(new Projectile(world, p.x, p.y,  1, -1, 7, new Fire(50)));
						world.addAnimation(new Projectile(world, p.x, p.y, -1,  1, 7, new Fire(50)));
						break;
				}
			}
		}
	}
}