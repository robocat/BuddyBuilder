 package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.*;
	
	public class Player extends FlxSprite {
		[Embed(source="doctor.png")] private var sprite : Class;
		[Embed(source="foot_steps.mp3")] private var soundEffect:Class;
		[Embed(source="deathscream1.mp3")] private var scream1:Class;
		[Embed(source="deathscream2.mp3")] private var scream2:Class;
		[Embed(source="deathscream3.mp3")] private var scream3:Class;
		[Embed(source="deathscream4.mp3")] private var scream4:Class;
		[Embed(source="deathscream5.mp3")] private var scream5:Class;
		[Embed(source="deathscream6.mp3")] private var scream6:Class;
		[Embed(source="deathscream7.mp3")] private var scream7:Class;
		[Embed(source="patient_dead.png")] private var deadSprite : Class;
		
		public var level : Level;
		
		public var playernumber : uint;
		private var area : FlxRect;
		private var slashing : Boolean = false;
		private var slash_down : Boolean = false;
		
		public function Player(playernumber:uint) : void {
			this.playernumber = playernumber;
			loadGraphic(sprite, false, false, 96, 96, false);
			addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7], 15, true);
			addAnimation("stand", [0]);
			addAnimation("slash", [8, 9, 10, 11, 12, 13, 14, 15, 15], 20, false);
			addAnimationCallback(animationCallback);
			play("stand");
			this.level = level;
			
			if (playernumber == 0) {
				area = new FlxRect(200, 40, 500, 820);
				x = 414;
				y = 655;
			} else {
				area = new FlxRect(740, 40, 500, 820);
				x = 942;
				y = 655;
			}
		}
		
		private function animationCallback(name:String, frame:uint, findex:uint) : void {
			trace(name);
			trace(frame);
			if (name == "slash" && frame == 8) {
				slashing = false;
			}
		}
		
		private function didSlash() : void {
			var colrect : FlxRect = new FlxRect(x, y, width, height);
			colrect.x += Math.sin(angle) * 32;
			colrect.y -= Math.cos(angle) * 32;
			
			var didHit : Boolean = false;
			for each (var npc : Patient in level.flock.patients) {
				if (colCheck(colrect, new FlxRect(npc.x, npc.y, npc.width, npc.height))) {
					var i : int = 0;
					for (i = 0; i < Math.random() * 5; i++) {
						level.backgroundLayer.add(new Blood(npc.x, npc.y));
					}

					var dead : Corpse = new Corpse(npc.x, npc.y);
					dead.angle = Math.random() * 360;
					dead.frame = Math.random() * 5;
					level.enemyLayer.add(dead);
					
					for (i = 0; i < Math.random() * 5; i++) {
						level.bloodLayer.add(new Blood(npc.x, npc.y));
					}
					
					level.enemyLayer.remove(npc);
					delete level.flock.patients[level.flock.patients.indexOf(npc)];
					level.addDrop();
					didHit = true;
				}
			}
			
			if(didHit) {
				var r : int = Math.random() * 7;
				if (r == 0) FlxG.play(scream1);
				if (r == 1) FlxG.play(scream2);
				if (r == 2) FlxG.play(scream3);
				if (r == 3) FlxG.play(scream4);
				if (r == 4) FlxG.play(scream5);
				if (r == 5) FlxG.play(scream6);
				if (r == 6) FlxG.play(scream7);
			}
		}
		
		override public function update() : void {
			super.update();
			
			if (this.level.gameState.state != GameState.STATE_PLAYING)
				return;
			
			var xchange : int = 0;
			var ychange : int = 0;
			
			var go_left : Boolean = false;
			var go_right : Boolean = false;
			var go_up : Boolean = false;
			var go_down : Boolean = false;
			var slash : Boolean = false;
			
			if ((playernumber == 1 && FlxG.keys.pressed("LEFT")) || (playernumber == 0 && FlxG.keys.pressed("A")))		go_left = true;
			if ((playernumber == 1 && FlxG.keys.pressed("RIGHT")) || (playernumber == 0 && FlxG.keys.pressed("D"))) 	go_right = true;
			if ((playernumber == 1 && FlxG.keys.pressed("UP")) || (playernumber == 0 && FlxG.keys.pressed("W")))		go_up = true;
			if ((playernumber == 1 && FlxG.keys.pressed("DOWN")) || (playernumber == 0 && FlxG.keys.pressed("S")))		go_down = true;
			if ((playernumber == 1 && FlxG.keys.pressed("SPACE")) || playernumber == 0 && FlxG.keys.pressed("ENTER"))	slash = true;
			if (FlxG.keys.pressed("K"))	FlxG.play(soundEffect);

			if (slash) {
				if (!slash_down) {
					slashing = true;
					play("slash");
					didSlash();
				}
				slash_down = true;
			} else slash_down = false;
			
			var obstacle : Obstacle;
			
			if (go_left) { x += (xchange = -5); } else if (go_right) { x += (xchange = 5); }
			
			for each (obstacle in level.obstacles) {
				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
				&& y + height > obstacle.y && y < obstacle.y + obstacle.height) {
					x -= xchange;
					break;
				}
			}
			
			if (go_up) { y += (ychange = -5); } else if (go_down) { y += (ychange = 5); }
			
			for each (obstacle in level.obstacles) {
				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
				&& y + height > obstacle.y && y < obstacle.y + obstacle.height) {
					y -= ychange;
					break;
				}
			}
			
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

			x = (x < area.x? area.x: x > area.x + area.width - width? area.x + area.width - width: x);
			y = (y < area.y? area.y: y > area.y + area.height - height? area.y + area.height - height: y);
			
			for each (var pickup : Pickup in level.pickups) {
				if (FlxCollision.pixelPerfectCheck(this, pickup)) {
					level.itemLayer.remove(pickup);
					pickup.apply(this);
					
					delete level.pickups[level.pickups.indexOf(pickup)];
					
//					var mask : uint = level.operation_table.pick_a_random_that_is_not_already_visible();
//					level.operation_table.add_to_body(mask);
					
					FlxG.play(soundEffect);
				}
			}
		}
		
		public function colCheck(r1 : FlxRect, r2 : FlxRect) : Boolean {
			if (r1.x + r1.width > r2.x && r1.x < r2.x + r2.width && r1.y + r1.height > r2.y && r1.y < r2.y + r2.height) {
				return true;
			}
			
			return false;
		}
	}
}
