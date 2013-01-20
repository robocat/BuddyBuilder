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
		[Embed(source="Ground hit 1.mp3")] private var groundhit1:Class;
		[Embed(source="Ground hit 2.mp3")] private var groundhit2:Class;
		[Embed(source="patient_dead.png")] private var deadSprite : Class;
		[Embed(source="swing.mp3")] private var swoosh : Class;
		[Embed(source="spikehit.mp3")] private var spikeRemove : Class;
		
		public var level : Level;
		
		public var hp : int;
		public var lastZombieCollisionCounter : uint;
		
		public var playernumber : uint;
		private var area : FlxRect;
		private var slashing : Boolean = false;
		private var slash_down : Boolean = false;
		
		private var player_title : FlxText = null;
		private var player_name : FlxText = null;
		
		private var controls_swapped : Boolean = false;
		private var controls_inverted : Boolean = false;
		
		private var spikeBallNoHit : int = 0;
		
		public var effects : Array = [];
		
		public function Player(playernumber:uint, playertitle:FlxText, playername:FlxText) : void {
			this.playernumber = playernumber;
			this.player_title = playertitle;
			this.player_name = playername;
			
			hp = 4;
			
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
		
		public function setHealth(health:int) : void {
			hp = health;
			
			if (playernumber == 0) {
				level.gameState.p1heart1.alpha = (health >= 1? 1: 0);
				level.gameState.p1heart2.alpha = (health >= 2? 1: 0);
				level.gameState.p1heart3.alpha = (health >= 3? 1: 0);
				level.gameState.p1heart4.alpha = (health >= 4? 1: 0);
				level.flash.alpha = 1;
				if (health == 0) level.gameState.gameOver(this);
			} else {
				level.gameState.p2heart1.alpha = (health >= 1? 1: 0);
				level.gameState.p2heart2.alpha = (health >= 2? 1: 0);
				level.gameState.p2heart3.alpha = (health >= 3? 1: 0);
				level.gameState.p2heart4.alpha = (health >= 4? 1: 0);
				level.flash.alpha = 1;
				if (health == 0) level.gameState.gameOver(level.gameState.getOpponnent(this));
			}
		}
		
		private function animationCallback(name:String, frame:uint, findex:uint) : void {
			if (name == "slash" && frame == 8) {
				slashing = false;
			} else if (name == "slash" && frame == 4) {
				didSlash();
			}
		}
		
		private function slashPatients(colrect : FlxRect) : Boolean {
			var didHit : Boolean = false;
			for each (var npc : Patient in level.flock.patients) {
				if (colCheck(colrect, new FlxRect(npc.x, npc.y, npc.width, npc.height))) {
					var i : int = 0;
					for (i = 0; i < Math.random() * 5; i++) {
						level.backgroundLayer.add(new Blood(npc.x, npc.y, level.backgroundLayer));
					}

					var dead : Corpse = new Corpse(npc.x, npc.y);
					dead.angle = Math.random() * 360;
					dead.frame = Math.random() * 5;
					
					var area : int = (dead.x > 720? 1: 0);
					dead.x = (area == 0? dead.x + dead.width > 660? 660 - dead.width: dead.x < 240? 240: dead.x: dead.x + dead.width > 1200? 1200 - dead.width: dead.x < 780? 780: dead.x);
					dead.y = (dead.y + dead.height > 840? 840 - dead.height: dead.y < 50? 50: dead.y);
					level.corpseLayer.add(dead);
					
					for (i = 0; i < Math.random() * 5; i++) {
						level.bloodLayer.add(new Blood(npc.x, npc.y, level.bloodLayer));
					}
					
					// Flee
					level.flock.flee(new FlxPoint(npc.x, npc.y), -Patient.RUN_VELOCITY, 300);
					
					level.enemyLayer.remove(npc);
					delete level.flock.patients[level.flock.patients.indexOf(npc)];
					
					if (Math.random() <= 0.5)
						level.addDrop(dead.x, dead.y);
					else if (Math.random() <= 0.1) {
						var spike : Spikeball = new Spikeball(npc.x, npc.y, level.itemLayer);
						level.spikeballs.push(spike);
						level.itemLayer.add(spike);
					}
					didHit = true;
				}
			}
			return didHit;
		}
		
		private function slashZombies(colrect : FlxRect) : Boolean {
			var didHit : Boolean = false;
			for each (var npc : Zombie in level.zombieFlock.zombies) {
				if (colCheck(colrect, new FlxRect(npc.x, npc.y, npc.width, npc.height))) {
					var i : int = 0;
					for (i = 0; i < Math.random() * 5; i++) {
						level.backgroundLayer.add(new Blood(npc.x, npc.y, level.backgroundLayer));
					}

					var dead : Corpse = new Corpse(npc.x, npc.y);
					dead.angle = Math.random() * 360;
					dead.frame = Math.random() * 5;
					
					var area : int = (dead.x > 720? 1: 0);
					dead.x = (area == 0? dead.x + dead.width > 660? 660 - dead.width: dead.x < 240? 240: dead.x: dead.x + dead.width > 1200? 1200 - dead.width: dead.x < 780? 780: dead.x);
					dead.y = (dead.y + dead.height > 840? 840 - dead.height: dead.y < 50? 50: dead.y);
					level.corpseLayer.add(dead);
					
					for (i = 0; i < Math.random() * 5; i++) {
						level.bloodLayer.add(new Blood(npc.x, npc.y, level.bloodLayer));
					}
					
					// Flee
					level.zombieFlock.flee(new FlxPoint(npc.x, npc.y), -Patient.RUN_VELOCITY, 300);
					
					level.enemyLayer.remove(npc);
					delete level.zombieFlock.zombies[level.zombieFlock.zombies.indexOf(npc)];
					
					if (Math.random() <= 0.5)
						level.addDrop(dead.x, dead.y);
					else if (Math.random() <= 0.1) {
						var spike : Spikeball = new Spikeball(npc.x, npc.y, level.itemLayer);
						level.spikeballs.push(spike);
						level.itemLayer.add(spike);
					}
					didHit = true;
				}
			}
			return didHit;
		}
		
		private function didSlash() : void {
			FlxG.play(swoosh);
			
			var colrect : FlxRect = new FlxRect(x, y, width, height);
			colrect.x += Math.sin(angle) * 32;
			colrect.y -= Math.cos(angle) * 32;
			
			for each (var spikeb : Spikeball in level.spikeballs) {
				if (colCheck(colrect, new FlxRect(spikeb.x, spikeb.y, spikeb.width, spikeb.height))) {
					delete level.spikeballs[level.spikeballs.indexOf(spikeb)];
					spikeb.remove();
					FlxG.play(spikeRemove);
				}
			}
			
			var didHitPatients : Boolean = this.slashPatients(colrect);
			var didHitZombies : Boolean = this.slashZombies(colrect);
			var didHit : Boolean = didHitPatients || didHitZombies;
			
			if(didHit) {
				var r : int = Math.random() * 7;
				if (r == 0) FlxG.play(scream1);
				if (r == 1) FlxG.play(scream2);
				if (r == 2) FlxG.play(scream3);
				if (r == 3) FlxG.play(scream4);
				if (r == 4) FlxG.play(scream5);
				if (r == 5) FlxG.play(scream6);
				if (r == 6) FlxG.play(scream7);
				
				r = Math.random() * 2;
				if (r == 0) FlxG.play(groundhit1);
				if (r == 1) FlxG.play(groundhit2);
			}
		}
		
		private function collisionWithZombies() : Boolean {
			var colrect : FlxRect = new FlxRect(x, y, width, height);

			var didHit : Boolean = false;
			for each (var npc : Zombie in level.zombieFlock.zombies) {
				if (colCheck(colrect, new FlxRect(npc.x, npc.y, npc.width, npc.height))) {
					didHit = true;
					break;
				}
			}
			return didHit;
		}
		
		override public function update() : void {
			super.update();
			if (color == 0xfd0000) color = 0xffffff;
			
			if (this.level.gameState.state != GameState.STATE_PLAYING)
				return;
				
			if(this.collisionWithZombies()) {
				if(this.lastZombieCollisionCounter == 0) {
					var our_hp : int = this.hp;
					our_hp--;
					if(our_hp >= 0) {
						this.setHealth(our_hp);
					}
					
				}
				lastZombieCollisionCounter++;
				if(this.lastZombieCollisionCounter > 100) {
					lastZombieCollisionCounter = 0;
				}
			} else {
				lastZombieCollisionCounter = 0;
			}
			
			var xchange : int = 0;
			var ychange : int = 0;
			
			var go_left : Boolean = false;
			var go_right : Boolean = false;
			var go_up : Boolean = false;
			var go_down : Boolean = false;
			var slash : Boolean = false;
			
			var keys0 : Boolean = (playernumber == 0); 
			var keys1 : Boolean = (playernumber == 1); 
			
			if(this.controls_swapped) {
				var tmp : Boolean = keys0;
				keys0 = keys1;
				keys1 = tmp;
			}
			
			if ((keys1 && FlxG.keys.pressed("LEFT"))  || (keys0 && FlxG.keys.pressed("A")))		go_left = true;
			if ((keys1 && FlxG.keys.pressed("RIGHT")) || (keys0 && FlxG.keys.pressed("D"))) 	go_right = true;
			if ((keys1 && FlxG.keys.pressed("UP"))    || (keys0 && FlxG.keys.pressed("W")))		go_up = true;
			if ((keys1 && FlxG.keys.pressed("DOWN"))  || (keys0 && FlxG.keys.pressed("S")))		go_down = true;
			if ((keys0 && FlxG.keys.pressed("SPACE")) || (keys1 && FlxG.keys.pressed("ENTER")))	slash = true;
			
			if (controls_inverted) {
				var tempLeft : Boolean = go_left;
				go_left = go_right;
				go_right = tempLeft;
				
				var tempUp : Boolean = go_up;
				go_up = go_down;
				go_down = tempUp; 
			}

			if (slash) {
				if (!slash_down) {
					slashing = true;
					play("slash");
				}
				slash_down = true;
			} else slash_down = false;
			
			var obstacle : Obstacle;
			
			if (go_left) { x += (xchange = -5); } else if (go_right) { x += (xchange = 5); }
			
			for each (obstacle in level.obstacles) {
				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
				&& y + height > obstacle.y && y < obstacle.y + obstacle.height) {
					x -= xchange;
					xchange = 0;
					break;
				}
			}
			
			if (go_up) { y += (ychange = -5); } else if (go_down) { y += (ychange = 5); }
			
			for each (obstacle in level.obstacles) {
				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
				&& y + height > obstacle.y && y < obstacle.y + obstacle.height) {
					y -= ychange;
					ychange = 0;
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
//					level.itemLayer.remove(pickup);
					
					pickup.apply();
					
					delete level.pickups[level.pickups.indexOf(pickup)];
					
//					var mask : uint = level.operation_table.pick_a_random_that_is_not_already_visible();
//					level.operation_table.add_to_body(mask);
					
					FlxG.play(soundEffect);
				}
			}
			
			if (spikeBallNoHit > 0) spikeBallNoHit--; else
			for each (var spike : Spikeball in level.spikeballs) {
				if (FlxCollision.pixelPerfectCheck(this, spike)) {
					x -= xchange;
					y -= ychange;
					color = 0xfd0000;
					setHealth(hp - 1);
					FlxG.play(groundhit1);
					spikeBallNoHit = 50;
					
					for (var i : int = 0; i < Math.random() * 5; i++) {
						level.bloodLayer.add(new Blood(x, y, level.bloodLayer));
					}
				}
			}
		}
		
		public function colCheck(r1 : FlxRect, r2 : FlxRect) : Boolean {
			if (r1.x + r1.width > r2.x && r1.x < r2.x + r2.width && r1.y + r1.height > r2.y && r1.y < r2.y + r2.height) {
				return true;
			}
			
			return false;
		}

		public function swapWithPlayer(other_player:Player) : void {
			var title : String = this.player_title.text;
			this.player_title.text = other_player.player_title.text;
			other_player.player_title.text = title;
			
			var name : String = this.player_name.text;
			this.player_name.text = other_player.player_name.text;
			other_player.player_name.text = name;

			var our_mask : uint = this.level.operation_table.get_body();
			this.level.operation_table.reset_body();
			var other_mask : uint = other_player.level.operation_table.get_body();
			other_player.level.operation_table.reset_body();
			this.level.operation_table.add_to_body(other_mask);			
			other_player.level.operation_table.add_to_body(our_mask);
			
			controls_swapped = ! controls_swapped;
			other_player.controls_swapped = ! other_player.controls_swapped;
		}
		
		public function invert_controls() : void {
			this.controls_inverted = true;
		}
		
		public function revert_controls() : void {
			this.controls_inverted = false;
		}
	}
}
