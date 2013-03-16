package  
{
	import flash.automation.ActionGenerator;
	import flash.geom.Point;
	public class Creature 
	{
		public var piecesOfAmulet:int = 0;
		
		public var glyph:String;
		private var fg:int;
		public function get x():int { return _x; }
		public function get y():int { return _y; }
		private var _x:int;
		private var _y:int;
		public var world:World;
		public var baseViewDistance:int;
		public var name:String;
		public var description:String;
		
		public var meleeAttack:int = 10;
		public var meleeDefence:int = 0;
		
		public var hp:int;
		
		public var isOnFireCounter:int = 0;
		public var isFrozenCounter:int = 0;
		public var isBlindCounter:int = 0;
		
		public function get viewDistance():int
		{
			if (isBlind)
				return 0;
			else
				return baseViewDistance;
		}
		
		public function get color():int 
		{
			if (isOnFireCounter > 0)
				return Color.lerp(this.fg, Color.fire, 0.2);
			else if (isFrozenCounter > 0)
				return Color.lerp(this.fg, Color.ice, 0.2);
			else
				return this.fg;
		}
		
		public function Creature(glyph:String, fg:int, x:int, y:int, name:String, description:String) 
		{
			this.glyph = glyph;
			this.fg = fg;
			this._x = x;
			this._y = y;
			this.hp = 100;
			this.baseViewDistance = 9;
			this.name = name;
			this.description = description;
		}
		
		public function get isBlind():Boolean
		{
			return isBlindCounter > 0;
		}
		
		public function update():void
		{
			if (isOnFireCounter > 0 && isFrozenCounter > 0)
			{
				var min:int = Math.min(isOnFireCounter, isFrozenCounter);
				isOnFireCounter -= min;
				isFrozenCounter -= min;
			}
			
			if (isOnFireCounter > 0)
			{
				HelpSystem.notify(this, "You're on fire!", null,
					"One of the hazards of bein an andventurer is fire. Specifically, being on fire. You'll lose health while on fire but eventually the flames will die down as long as you avoid open flames.");
					
				hp -= Math.floor(isOnFireCounter / 10) + 1;
				isOnFireCounter--;
				bleed();
			}
			
			if (isBlindCounter > 0)
			{
				HelpSystem.notify(this, "You're blind!", null,
					"You can't see anything in here! Give it a few turns and you'll be able to see again. I just hope you remember where the nearest safe area is....");
					
				isBlindCounter--;
			}
			
			if (isFrozenCounter > 0)
			{
				HelpSystem.notify(this, "You're frozen solid!", null,
					"Freezing solid is just part of the job of being an adventurer. Wait a few turns and, if you're still alive, you'll be able to move again. You can't do anything else anyway.");
					
				isFrozenCounter--;
			}
			else
			{
				updateInternal();
			}
			
			if (hp < 25)
				bleed();
			if (hp < 10)
				bleed();
			if (hp < 5)
				bleed();
		}
		
		public function updateInternal():void
		{
		}
		
		public function teleportTo(nx:int, ny:int):void
		{
			world.move(this, x, y, nx, ny);
			_x = nx;
			_y = ny;
		}
		
		public function walk(mx:int, my:int):void
		{
			if (mx == 0 && my == 0)
				return;
			
			var other:Creature = world.getCreature(x + mx, y + my);
			
			if (other != null)
			{
				if (doesHate(other) || isBlind)
					attack(other);
			}
			else if (world.getTile(x + mx, y + my) == Tile.closedDoor)
			{
				if (canOpenDoors())
					world.setTile(x + mx, y + my, Tile.openDoor);
			}
			else if (world.getTile(x + mx, y + my).isWalkable)
			{
				var oldRoom:Room = world.getRoom(x, y);
				world.move(this, x, y, x + mx, y + my);
				_x += mx;
				_y += my;
				var newRoom:Room = world.getRoom(x, y);
				
				if (oldRoom != newRoom && newRoom != null && newRoom.description != null)
					HelpSystem.notify(this, newRoom.name, null, newRoom.description);
			}
		}
		
		public function enterRoom(room:Room):void
		{
			
		}
		
		public function doesHate(other:Creature):Boolean 
		{
			return other != null && other != this && (other is Player || other is Hero);
		}
		
		public function canSee(other:Creature):Boolean
		{
			return canSeeLocation(other.x, other.y);
		}
		
		public function canSeeLocation(tx:int, ty:int):Boolean
		{
			if (x < 0 && y < 0)
				return true; // teleporting etc...
				
			var dist:int = 0;
			for each (var p:Point in Line.betweenCoordinates(x, y, tx, ty).points)
			{
				if (dist++ > viewDistance)
					return false;
					
				if (!world.getTile(p.x, p.y).allowsVision)
					return false;
			}
			return true;
		}
		
		public function canOpenDoors():Boolean
		{
			return glyph == "@";
		}
		
		public function attack(other:Creature):void
		{
			var amount:int = Math.max(meleeAttack - other.meleeDefence, 1);
			
			other.hp -= amount;
			
			bleed();
		}
		
		public function bleed():void
		{
			world.addBlood(x, y);
		}
		
		public function wander():void
		{
			var mx:int = Math.floor(Math.random() * 3 - 1);
			var my:int = Math.floor(Math.random() * 3 - 1);
			
			walk(mx, my);
		}
		
		public function heal(amount:int):void 
		{
			hp = Math.min(hp + amount, 100);
		}
	}
}