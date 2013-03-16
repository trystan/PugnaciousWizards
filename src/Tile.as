package  
{
	public class Tile 
	{
		public static var outOfBounds:Tile = new Tile(250, Color.hsv(100, 30, 30), Color.hsv(100, 20, 20), false, false,
				"Out of bounds", null);
		
		public static var grass:Tile = new Tile(250, Color.hsv(100, 30, 30), Color.hsv(100, 20, 20), true, true,
				"grass", null);
		public static var tree:Tile = new Tile(5, Color.hsv(120, 50, 40), Color.hsv(120, 20, 20), false, true,
				"a tree", null);
		public static var burningTree3:Tile = new Tile(5, Color.lerp(Color.fire, Color.hsv(120, 50, 40), 0.3), Color.lerp(Color.fire, Color.hsv(120, 20, 20), 0.2), false, true,
				"a burning tree", "You can feel the heat from the tree as it burns. Don't get too close.");
		public static var burningTree2:Tile = new Tile(5, Color.lerp(Color.fire, Color.hsv(120, 50, 40), 0.5), Color.lerp(Color.fire, Color.hsv(120, 20, 20), 0.4), false, true,
				"a burning tree", "You can feel the heat from the tree as it burns. Don't get too close.");
		public static var burningTree1:Tile = new Tile(5, Color.lerp(Color.fire, Color.hsv(120, 50, 40), 0.7), Color.lerp(Color.fire, Color.hsv(120, 20, 20), 0.6), false, true,
				"a burning tree", "You can feel the heat from the tree as it burns. Don't get too close.");
		public static var pit:Tile = new Tile(250, Color.hsv(60, 25, 15), Color.hsv(60, 25, 2), false, true,
				"a bottomless pit", "You can't see any bottom to this - just blackness. Be extra carefull around it.");
		
		public static var burntFloor:Tile = new Tile(250, Color.hsv(30, 10, 20), Color.hsv(30, 5, 10), true, true,
				"burnt floor", null);
		public static var tile1:Tile = new Tile(32, Color.hsv(100, 0, 10), Color.hsv(100, 0, 10), true, true,
				"tile floor", null);
		public static var tile2:Tile = new Tile(32, Color.hsv(100, 0, 12), Color.hsv(100, 0, 12), true, true,
				"tile floor", null);
		public static var tile3:Tile = new Tile(32, Color.hsv(100, 0, 14), Color.hsv(100, 0, 14), true, true,
				"tile floor", null);
		public static var portal:Tile = new Tile(177, Color.hsv(100, 0, 14), Color.hsv(100, 0, 14), true, true,
				"a magic portal", "This magic portal is almost too bright to look at. You can't see where it goes. Maybe if you step closer?");
		public static var exposedTrap:Tile = new Tile(94, Color.hsv(0, 80, 50), Color.hsv(100, 0, 12), true, true,
				"an exposed trap", "A hidden trap has gone off and is now exposed and harmless.");
		public static var wall:Tile = new Tile(35, Color.hsv(100, 0, 50), Color.hsv(100, 0, 40), false, false,
				"wall", null);
		public static var crumbledWall:Tile = new Tile(35, Color.lerp(Color.ruins, Color.hsv(100, 0, 50), 0.4), Color.lerp(Color.ruins, Color.hsv(100, 0, 40), 0.6), false, false,
				"crumbling wall", null);
		
		public static var arrowTower:Tile = new Tile(8, Color.hsv(100, 0, 40), Color.hsv(100, 0, 20), false, false,
				"an arrow tower", "This menacing tower has the tips of arrows pointing out of each side. It's best to step carefully when near it.");
		
		public static var rotatingTower1:Tile = new Tile(47, Color.hsv(0, 10, 20), Color.hsv(0, 10, 40), false, false,
				"a rotating tower", "This tower rotates. And shoots fire.");
		public static var rotatingTower2:Tile = new Tile(196, Color.hsv(0, 10, 20), Color.hsv(0, 10, 40), false, false,
				"a rotating tower", "This tower rotates. And shoots fire.");
		public static var rotatingTower3:Tile = new Tile(92, Color.hsv(0, 10, 20), Color.hsv(0, 10, 40), false, false,
				"a rotating tower", "This tower rotates. And shoots fire.");
		public static var rotatingTower4:Tile = new Tile(179, Color.hsv(0, 10, 20), Color.hsv(0, 10, 40), false, false,
				"a rotating tower", "This tower rotates. And shoots fire.");
		
				
		public static var closedDoor:Tile = new Tile(43, Color.hsv(30, 60, 60), Color.hsv(30, 60, 50), true, false,
				"closed door", null);
		public static var openDoor:Tile = new Tile(47, Color.hsv(30, 60, 60), Color.hsv(30, 60, 50), true, true,
				"open door", null);
		public static var burningDoor10:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor9:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor8:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor7:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor6:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor5:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor4:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor3:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor2:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		public static var burningDoor1:Tile = new Tile(47, Color.lerp(Color.fire, Color.hsv(30, 60, 60), 0.5), Color.lerp(Color.fire, Color.hsv(30, 60, 50), 0.5), true, true,
				"burning door", "You can feel the heat from the door as it burns. Don't get too close.");
		
		public static var timer5:Tile = new Tile(53, Color.hsv(0, 0, 50), Color.hsv(100, 0, 14), true, true,
				"a timer", "Something is going to happen here in 5 turns. Maybe you don't want to be near it? Or maybe you do. Only one way to find out.");
		public static var timer4:Tile = new Tile(52, Color.hsv(0, 3, 50), Color.hsv(100, 0, 14), true, true,
				"a timer", "Something is going to happen here in 4 turns. Maybe you don't want to be near it? Or maybe you do. Only one way to find out.");
		public static var timer3:Tile = new Tile(51, Color.hsv(0, 6, 50), Color.hsv(100, 0, 14), true, true,
				"a timer", "Something is going to happen here in 3 turns. Maybe you don't want to be near it? Or maybe you do. Only one way to find out.");
		public static var timer2:Tile = new Tile(50, Color.hsv(0, 9, 50), Color.hsv(100, 0, 14), true, true,
				"a timer", "Something is going to happen here in 2 turns. Maybe you don't want to be near it? Or maybe you do. Only one way to find out.");
		public static var timer1:Tile = new Tile(49, Color.hsv(0, 12, 50), Color.hsv(100, 0, 14), true, true,
				"a timer", "Something is going to happen here in 1 turns. Maybe you don't want to be near it? Or maybe you do. Only one way to find out.");
		public static var timer0:Tile = new Tile(48, Color.hsv(0, 15, 50), Color.hsv(100, 0, 14), true, true,
				"a timer", "Something is going to happen here. Maybe you don't want to be near it? Or maybe you do. Only one way to find out.");
				
		public var glyph:String;
		public var fg:int;
		public var bg:int;
		public var isWalkable:Boolean;
		public var allowsVision:Boolean;
		public var isTree:Boolean;
		public var isPortal:Boolean = false;
		public var name:String;
		public var description:String;
		
		public function Tile(glyph:int, fg:int, bg:int, isWalkable:Boolean, allowsVision:Boolean, name:String, description:String)
		{
			this.glyph = String.fromCharCode(glyph);
			this.fg = fg;
			this.bg = bg;
			this.isWalkable = isWalkable;
			this.allowsVision = allowsVision;
			this.isTree = glyph == 5;
			this.name = name;
			this.description = description;
		}
	}
}