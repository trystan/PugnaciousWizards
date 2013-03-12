package  
{
	public class Tile 
	{
		public static var outOfBounds:Tile = new Tile(250, Color.hsv(100, 30, 30), Color.hsv(100, 20, 20), false, false);
		
		public static var grass:Tile = new Tile(250, Color.hsv(100, 30, 30), Color.hsv(100, 20, 20), true, true);
		public static var tree:Tile = new Tile(5, Color.hsv(120, 50, 40), Color.hsv(120, 20, 20), false, true);
		public static var burningTree3:Tile = new Tile(5, Color.lerp(Color.fire, Color.hsv(120, 50, 40), 0.3), Color.lerp(Color.fire, Color.hsv(120, 20, 20), 0.2), false, true);
		public static var burningTree2:Tile = new Tile(5, Color.lerp(Color.fire, Color.hsv(120, 50, 40), 0.5), Color.lerp(Color.fire, Color.hsv(120, 20, 20), 0.4), false, true);
		public static var burningTree1:Tile = new Tile(5, Color.lerp(Color.fire, Color.hsv(120, 50, 40), 0.7), Color.lerp(Color.fire, Color.hsv(120, 20, 20), 0.6), false, true);
		public static var pit:Tile = new Tile(250, Color.hsv(60, 25, 15), Color.hsv(60, 25, 2), false, true);
		
		public static var burntFloor:Tile = new Tile(250, Color.hsv(30, 10, 20), Color.hsv(30, 5, 10), true, true);
		public static var tile1:Tile = new Tile(32, Color.hsv(100, 0, 10), Color.hsv(100, 0, 10), true, true);
		public static var tile2:Tile = new Tile(32, Color.hsv(100, 0, 12), Color.hsv(100, 0, 12), true, true);
		public static var tile3:Tile = new Tile(32, Color.hsv(100, 0, 14), Color.hsv(100, 0, 14), true, true);
		public static var wall:Tile = new Tile(35, Color.hsv(100, 0, 50), Color.hsv(100, 0, 40), false, false);
		public static var crumbledWall:Tile = new Tile(35, Color.lerp(Color.ruins, Color.hsv(100, 0, 50), 0.4), Color.lerp(Color.ruins, Color.hsv(100, 0, 40), 0.6), false, false);
		
		public static var arrowTower:Tile = new Tile(8, Color.hsv(100, 0, 40), Color.hsv(100, 0, 20), false, false);
		
		public static var closedDoor:Tile = new Tile(43, Color.hsv(30, 60, 60), Color.hsv(30, 60, 50), true, false);
		public static var openDoor:Tile = new Tile(47, Color.hsv(30, 60, 60), Color.hsv(30, 60, 50), true, true);
		public static var burningDoor10:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor9:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor8:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor7:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor6:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor5:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor4:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor3:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor2:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		public static var burningDoor1:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true);
		
		public var glyph:String;
		public var fg:int;
		public var bg:int;
		public var isWalkable:Boolean;
		public var allowsVision:Boolean;
		public var isTree:Boolean;
		
		public function Tile(glyph:int, fg:int, bg:int, isWalkable:Boolean, allowsVision:Boolean)
		{
			this.glyph = String.fromCharCode(glyph);
			this.fg = fg;
			this.bg = bg;
			this.isWalkable = isWalkable;
			this.allowsVision = allowsVision;
			this.isTree = glyph == 5;
		}
	}
}