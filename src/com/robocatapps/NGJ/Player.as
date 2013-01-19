package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.*;
	
	public class Player extends FlxSprite {
		[Embed(source="player.png")] private var sprite : Class;
		
		private var playernumber : uint;
		private var scene : GameState;
		
		private var player1area : FlxRect = new FlxRect(200, 40, 500, 820);
		private var player2area : FlxRect = new FlxRect(740, 40, 500, 820);
		
		public function Player(playernumber:uint, x:uint, y:uint, scene:GameState) : void {
			this.playernumber = playernumber;
			loadGraphic(sprite, false, false, 128, 128, false);
			this.x = x;
			this.y = y;
			this.scene = scene;
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
			
			for each (var obstacle : FlxSprite in scene.obstacles) {
				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
				&& y + height > obstacle.y && x < obstacle.y + obstacle.height) {
					x -= xchange;
					y -= ychange;
					break;
				}
			}
			
			x = (x < 0? 0: x > FlxG.width - width? FlxG.width - width: x);
			y = (y < 0? 0: y > FlxG.height - height? FlxG.height - height: y);
			
			for each (var pickup : Pickup in scene.pickups) {
				if (FlxCollision.pixelPerfectCheck(this, pickup)) {
					scene.remove(pickup);
					delete scene.pickups[scene.pickups.indexOf(pickup)];
				}
			}
		}
	}
}
