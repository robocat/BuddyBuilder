 package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.*;
	
	public class Player extends FlxSprite {
		[Embed(source="doctor.png")] private var sprite : Class;
		
		public var level : Level;
		
		private var playernumber : uint;
		private var area : FlxRect;
		private var slashing : Boolean = false;
		private var slash_down : Boolean = false;
		
		public function Player(playernumber:uint) : void {
			this.playernumber = playernumber;
			loadGraphic(sprite, false, false, 92, 92, false);
			addAnimation("walk", [0, 1], 10, true);
			addAnimation("stand", [0]);
			addAnimation("slash", [2, 3, 4, 4], 20, false);
			addAnimationCallback(animationCallback);
			play("stand");
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
		
		private function animationCallback(name:String, frame:uint, findex:uint) : void {
			trace(name);
			trace(frame);
			if (name == "slash" && frame == 3) {
				slashing = false;
			}
		}
		
		private function didSlash() : void {
			// called when the player slashes with his cleaver
		}
		
		override public function update() : void {
			var xchange : int = 0;
			var ychange : int = 0;
			
			var go_left : Boolean = false;
			var go_right : Boolean = false;
			var go_up : Boolean = false;
			var go_down : Boolean = false;
			var slash : Boolean = false;
			
			if ((playernumber == 0 && FlxG.keys.pressed("LEFT")) || (playernumber == 1 && FlxG.keys.pressed("A")))		go_left = true;
			if ((playernumber == 0 && FlxG.keys.pressed("RIGHT")) || (playernumber == 1 && FlxG.keys.pressed("D"))) 	go_right = true;
			if ((playernumber == 0 && FlxG.keys.pressed("UP")) || (playernumber == 1 && FlxG.keys.pressed("W")))		go_up = true;
			if ((playernumber == 0 && FlxG.keys.pressed("DOWN")) || (playernumber == 1 && FlxG.keys.pressed("S")))		go_down = true;
			if ((playernumber == 0 && FlxG.keys.pressed("SPACE")) || playernumber == 1 && FlxG.keys.pressed("ENTER"))	slash = true;
			
			if (slash) {
				if (!slash_down) {
					slashing = true;
					play("slash");
					didSlash();
				}
				slash_down = true;
			} else slash_down = false;
			
			if (go_left) { x += (xchange = -5); } else if (go_right) { x += (xchange = 5); }
			if (go_up) { y += (ychange = -5); } else if (go_down) { y += (ychange = 5); }
			
			if (go_left) { angle = (go_up? -90+45: go_down? -90-45: -90); }
			else if (go_right) { angle = (go_up? 90-45: go_down? 90+45: 90); }
			else if (go_up) { angle = 0; }
			else if (go_down) { angle = 180; }
			
			if (!slashing) {
				if (go_left || go_right || go_up || go_down) {
					play("walk");
				} else {
					play("stand");
				}
			}

			for each (var obstacle : Obstacle in level.obstacles) {
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
