 package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.*;
	
	public class Player extends FlxSprite {
		[Embed(source="player.png")] private var sprite : Class;
		
		private var playernumber : uint;
		public var level : Level;
		
		private var area : FlxRect;
		
		public function Player(playernumber:uint) : void {
			this.playernumber = playernumber;
			loadGraphic(sprite, false, false, 128, 128, false);
			this.level = level;
			
			if (playernumber == 1) {
				area = new FlxRect(200, 40, 500, 820);
				x = 300;
				y = 700;
			} else {
				area = new FlxRect(740, 40, 500, 820);
				x = 840;
				y = 700;
			}
		}
		
		override public function update() : void {
			var xchange : int = 0;
			var ychange : int = 0;
			
			if ((playernumber == 0 && FlxG.keys.pressed("LEFT")) || (playernumber == 1 && FlxG.keys.pressed("A"))) {
				x += (xchange = -5);
				frame = 1;
			} else if ((playernumber == 0 && FlxG.keys.pressed("RIGHT")) || (playernumber == 1 && FlxG.keys.pressed("D"))) {
				x += (xchange = 5);
				frame = 0;
			}
			
			if ((playernumber == 0 && FlxG.keys.pressed("UP")) || (playernumber == 1 && FlxG.keys.pressed("W"))) {
				y += (ychange = -5);
			} else if ((playernumber == 0 && FlxG.keys.pressed("DOWN")) || (playernumber == 1 && FlxG.keys.pressed("S"))) {
				y += (ychange = 5);
			}
			
			for each (var obstacle : FlxSprite in level.obstacles) {
				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
				&& y + height > obstacle.y && x < obstacle.y + obstacle.height) {
					x -= xchange;
					y -= ychange;
					break;
				}
			}
			
			x = (x < area.x? area.x: x > area.x + area.width - width? area.x + area.width - width: x);
			y = (y < area.y? area.y: y > area.y + area.height - height? area.y + area.height - height: y);
			
			for each (var pickup : Pickup in level.pickups) {
				if (FlxCollision.pixelPerfectCheck(this, pickup)) {
					level.remove(pickup);
					delete level.pickups[level.pickups.indexOf(pickup)];
				}
			}
		}
	}
}
