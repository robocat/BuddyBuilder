package com.robocatapps.NGJ {
	import org.flixel.*;
	import flash.utils.getTimer;
	
	public class Pickup extends FlxSprite {
		
		[Embed(source="heart_drop.png")] private var heartDropSprite : Class;
		[Embed(source="light_pickup.png")] private var lightSprite : Class;
		[Embed(source="speed_pickup.png")] private var speedSprite : Class;
		[Embed(source="swap_pickup.png")] private var swapSprite : Class;
		[Embed(source="zombie_pickup.png")] private var zombieSprite : Class;
		[Embed(source="inverted_pickup.png")] private var invertedSprite : Class;
		[Embed(source="death_pickup.png")] private var deathSprite : Class;
		[Embed(source="horde.png")] private var hordeSprite : Class;
		[Embed(source="spikeball drop.png")] private var spikeballSprite : Class;
		
		[Embed(source="left_leg_drop.png")] private var leftLegSprite : Class;
		[Embed(source="right_leg_drop.png")] private var rightLegSprite : Class;
		[Embed(source="left_arm_drop.png")] private var leftArmSprite : Class;
		[Embed(source="right_arm_drop.png")] private var rightArmSprite : Class;
		[Embed(source="head_drop.png")] private var headSprite : Class;
		[Embed(source="torso_drop.png")] private var torsoSprite : Class;
		
		[Embed(source="head.mp3")] private var headSpeaker : Class;
		[Embed(source="left arm.mp3")] private var leftarmSpeaker : Class;
		[Embed(source="left leg.mp3")] private var leftlegSpeaker : Class;
		[Embed(source="right arm.mp3")] private var rightarmSpeaker : Class;
		[Embed(source="right leg.mp3")] private var rightlegSpeaker : Class;
		[Embed(source="torso.mp3")] private var torsoSpeaker : Class;
		[Embed(source="bodypart.mp3")] private var bodypartSound : Class;
		[Embed(source="darkness.mp3")] private var darknessSpeaker : Class;
		[Embed(source="health pickup.mp3")] private var healthSpeaker : Class;
		[Embed(source="death.mp3")] private var deathSpeaker : Class;
		[Embed(source="horde.mp3")] private var hordeSpeaker : Class;
		[Embed(source="spikeball_drop.mp3")] private var spikeballSpeaker : Class;
		[Embed(source="cannot_add_to_body.mp3")] private var bodyFailSpeaker : Class;
		[Embed(source="swap.mp3")] private var swapSpeaker : Class;
		[Embed(source="zombies.mp3")] private var zombiesSpeaker : Class;
		[Embed(source="body fail.mp3")] private var bodyfail : Class;
		[Embed(source="speed.mp3")] private var speedSpeaker : Class;
		[Embed(source="inverted.mp3")] private var invertedSpeaker : Class;
		
		public static const DROP_HEALTH : String = "health";
		public static const DROP_LIGHT : String = "light";
		public static const DROP_SPEED : String = "speed";
		public static const DROP_SWAP : String = "swap";
		public static const DROP_ZOMBIE : String = "zombie";
		public static const DROP_INVERTED : String = "inverted";
		public static const DROP_DEATH : String = "death";
		public static const DROP_HORDE : String = "horde";
		public static const DROP_SPIKEBALL : String = "spikeball";
		
		public static const DROP_LEFTLEG : String = "left_leg";
		public static const DROP_RIGHTLEG : String = "right_leg";
		public static const DROP_LEFTARM : String = "left_arm";
		public static const DROP_RIGHTARM : String = "right_arm";
		public static const DROP_HEAD : String = "head";
		public static const DROP_TORSO : String = "torso";
		
		public static const DROP_TYPES : Array = [DROP_HORDE, DROP_HORDE, DROP_SPIKEBALL, DROP_DEATH, DROP_ZOMBIE, DROP_INVERTED, DROP_SWAP, DROP_SPEED, DROP_LIGHT, DROP_LEFTLEG, DROP_RIGHTLEG, DROP_LEFTARM, DROP_RIGHTARM, DROP_HEAD, DROP_TORSO, DROP_HEALTH];
		public static const DROP_NAMES : Array = ["HORDE", "HORDE", "SPIKE BALL", "DEATH", "ZOMBIE", "INVERTED", "SWAP", "SPEED", "DARKNESS", "LEFT LEG", "RIGHT LEG", "LEFT ARM", "RIGHT ARM", "HEAD", "TORSO", "HEALTH"];
		
		public static const STATE_DROPPED : uint = 1;
		public static const STATE_APPLIED : uint = 2;
		public static const STATE_EFFECTING : uint = 3;
		public static const STATE_EXPIRED : uint = 4;
		
		public var player : Player;
		public var type : String;
		public var state : uint = Pickup.STATE_DROPPED;
		public var sprite : Class;
		
		
		private static const TICKS_PER_SECOND : uint = 24;
		private static const COOLDOWN_IN_SECONDS : uint = 10;
		
		private var timer : int = -1;
		
		
		
		
		public var timeoutCount : uint = 0;
		public var maxCount : uint = 300;
		
		public var timedOut : Boolean = false;
		
		public var speed : uint = 0;
		private var area : uint = 0;
		
		public function Pickup(x:uint, y:uint, type:String, player : Player, speed:uint = 0, angle:int = 0) : void {
			super(x, y);
			this.speed = speed;
			this.angle = 0;
			this.player = player;
			
			
			area = (x > 720? 1: 0);
			
			this.type = type;
			
			if (type == DROP_HEALTH) {
				loadGraphic(heartDropSprite, false, false, 44, 40, false);
				sprite = heartDropSprite;
			} else if (type == DROP_LIGHT) {
				loadGraphic(lightSprite, false, false, 48, 52, false);
				sprite = lightSprite;
			} else if (type == DROP_DEATH) {
				loadGraphic(deathSprite, false, false, 48, 52, false);
				sprite = deathSprite;
			} else if (type == DROP_SPEED) {
				loadGraphic(speedSprite, false, false, 48, 52, false);
				sprite = speedSprite;
			} else if (type == DROP_SWAP) {
				loadGraphic(swapSprite, false, false, 48, 52, false);
				sprite = swapSprite;
			} else if (type == DROP_ZOMBIE) {
				loadGraphic(zombieSprite, false, false, 48, 52, false);
				sprite = zombieSprite;
			} else if (type == DROP_SPIKEBALL) {
				loadGraphic(spikeballSprite, false, false, 48, 52, false);
				sprite = spikeballSprite;
			} else if (type == DROP_INVERTED) {
				loadGraphic(invertedSprite, false, false, 48, 52, false);
				sprite = invertedSprite;
			} else if (type == DROP_HORDE) {
				loadGraphic(hordeSprite, false, false, 48, 52, false);
				sprite = hordeSprite;
			} else if (type == DROP_LEFTLEG) {
				loadGraphic(leftLegSprite, false, false, 52, 114, false);
				sprite = leftLegSprite;
			} else if (type == DROP_RIGHTLEG) {
				loadGraphic(rightLegSprite, false, false, 52, 116, false);
				sprite = rightLegSprite;
			} else if (type == DROP_LEFTARM) {
				loadGraphic(leftArmSprite, false, false, 44, 80, false);
				sprite = leftArmSprite;
			} else if (type == DROP_RIGHTARM) {
				loadGraphic(rightArmSprite, false, false, 46, 82, false);
				sprite = rightArmSprite;
			} else if (type == DROP_HEAD) {
				loadGraphic(headSprite, false, false, 40, 54, false);
				sprite = headSprite;
			} else if (type == DROP_TORSO) {
				loadGraphic(torsoSprite, false, false, 72, 110, false);
				sprite = torsoSprite;
			} else {
				trace('lol ' + type);
			}
			
		}
		
		public function announce() : void {
			if (type == DROP_LEFTLEG) {
				FlxG.play(leftlegSpeaker);
			} else if (type == DROP_RIGHTLEG) {
				FlxG.play(rightlegSpeaker);
			} else if (type == DROP_LEFTARM) {
				FlxG.play(leftarmSpeaker);
			} else if (type == DROP_RIGHTARM) {
				FlxG.play(rightarmSpeaker);
			} else if (type == DROP_HEAD) {
				FlxG.play(headSpeaker);
			} else if (type == DROP_TORSO) {
				FlxG.play(torsoSpeaker);
			} else {
				return;
			}
			
			FlxG.play(bodypartSound);
		}
		
		public function is_body_part() : Boolean {
			return 	this.type != DROP_LIGHT &&
					this.type != DROP_SPEED &&
					this.type != DROP_SWAP &&
					this.type != DROP_ZOMBIE &&
					this.type != DROP_INVERTED &&
					this.type != DROP_HEALTH &&
					this.type != DROP_DEATH &&
					this.type != DROP_HORDE &&
					this.type != DROP_SPIKEBALL;
		}
		
		public function to_body_part() : uint {
			if (!is_body_part())
				return 0;
			
			if (type == DROP_LEFTLEG) {
				return OperationTable.LEFT_LEG;
			} else if (type == DROP_RIGHTLEG) {
				return OperationTable.RIGHT_LEG;
			} else if (type == DROP_LEFTARM) {
				return OperationTable.LEFT_ARM;
			} else if (type == DROP_RIGHTARM) {
				return OperationTable.RIGHT_ARM;
			} else if (type == DROP_HEAD) {
				return OperationTable.HEAD;
			} else if (type == DROP_TORSO) {
				return OperationTable.TORSO;
			} else {
				return 0;
			}
		}
		
		public function text_for_pickup() : String {
			return DROP_NAMES[DROP_TYPES.indexOf(this.type)];
		}
		
		public function apply() : void {
			this.state = STATE_APPLIED;
			this.alpha = 0;
			
			if(is_body_part()){
				var part : uint = this.to_body_part();
				if (player.level.operation_table.can_add_to_body(part)) {
					new HUDSprite(sprite, player.playernumber, text_for_pickup(), player.level.gameState.textLayer, true);
					player.level.operation_table.add_to_body(this.to_body_part());
					announce();
				} else {
					FlxG.play(bodyFailSpeaker);
				}
			} else if (this.type == DROP_HEALTH) {
				player.setHealth(8);
			} else if (this.type == DROP_ZOMBIE) {
				new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
				var zopponent : Player = player.level.getOpponent();
				zopponent.level.switchToZombies();
				zopponent.effects.push(this);
				FlxG.play(zombiesSpeaker);
			} else {
				var opponent : Player = player.level.getOpponent();
				
				if (type == DROP_LIGHT) {
					new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					opponent.level.turnOffLights();
					opponent.effects.push(this);
				} else if (type == DROP_SWAP) {
					new HUDSprite(sprite, player.playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					player.swapWithPlayer(player.level.getOpponent());
				} else if (type == DROP_INVERTED) {
					new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					opponent.invert_controls();
					opponent.effects.push(this);
				} else if (type == DROP_DEATH) {
					new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					for each (var patient : Patient in opponent.level.flock.patients) {
						opponent.killPatient(patient, false);
					}
				} else if (type == DROP_HORDE) {
					new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					opponent.level.horde();
				} else if(type == DROP_SPIKEBALL) {
					for (var i : int = 0; i < 3; i++) {
						var spike : Spikeball = new Spikeball(250 + Math.random() * 400 + (player.x < 720? 540: 0), 90 + Math.random() * 720, opponent.level.itemLayer);
						opponent.level.spikeballs.push(spike);
						opponent.level.itemLayer.add(spike);
					}
				} else if (type == DROP_SPEED) {
					new HUDSprite(sprite, player.level.gameState.getOpponnent(player).playernumber, text_for_pickup(), player.level.gameState.textLayer, false);
					opponent.speed = 30;
					opponent.effects.push(this);
				}

				
				if (type == DROP_LIGHT) {
					FlxG.play(darknessSpeaker);
				} else if (type == DROP_HEALTH) {
					FlxG.play(healthSpeaker);
				} else if (type == DROP_DEATH) {
					FlxG.play(deathSpeaker);
				} else if (type == DROP_HORDE) {
					FlxG.play(hordeSpeaker);
				} else if (type == DROP_SPIKEBALL) {
					FlxG.play(spikeballSpeaker);
				} else if (type == DROP_SWAP) {
					FlxG.play(swapSpeaker);
				} else if (type == DROP_SPEED) {
					FlxG.play(speedSpeaker);
				} else if (type == DROP_INVERTED) {
					FlxG.play(invertedSpeaker);
				}
			}
		}

		private function alpha_from_tick(tick : uint) : Number {
			if (this.state != STATE_DROPPED)
				return 0;
			
			if(tick < 2) return 0.2;
			if(tick < 5) return 0.3;
			if(tick < 8) return 0.8;
			if(tick < 10) return 1.0;
			if(tick < 12) return 0.3;
			if(tick < 15) return 1.0;
			if(tick < 20) return 0.8;
			if(tick < 25) return 1.0;
			if(tick < 30) return 0.8;
			if(tick < 55) return 1.0;
			if(tick < 60) return 0.8;
			if(tick < 85) return 1.0;
			if(tick < 90) return 0.8;
			if(tick < 130) return 1.0;
			if(tick < 135) return 0.8;
			if(tick < 170) return 1.0;
			if(tick < 175) return 0.8;
			if(tick > 176) {
				
				return 1;
			}
			return 1.0;
		}
		
		public function timerInSeconds() : int {
			return COOLDOWN_IN_SECONDS - (getTimer() - timer) * 0.001;
		}
		
		override public function update():void {
			super.update();
			
			if (state == STATE_DROPPED && speed > 0) {
				speed -= 0.1;
				x += Math.sin(angle) * speed;
				y -= Math.cos(angle) * speed;
				
				x = (area == 0? x > 700? 700: x < 200? 200: x: x > 1240? 1240: x < 740? 740: x);
				y = (y > 860? 860: y < 40? 40: y);
				
			}
			
			if (state == STATE_APPLIED)
			{
				timer = getTimer();
				state = STATE_EFFECTING;
			}
			
				
			if (state == STATE_EFFECTING && (getTimer() - timer) * 0.001 > COOLDOWN_IN_SECONDS) {
				var opponent : Player = player.level.getOpponent();
					
				if (type == DROP_LIGHT) {
					opponent.level.turnOnLights();
				} else if (type == DROP_INVERTED) {
					opponent.revert_controls();
				} else if (type == DROP_SPEED) {
					opponent.speed = 3;
				} else if (type == DROP_ZOMBIE) {
					for each (var zombie : Zombie in opponent.level.zombieFlock.zombies) {
						opponent.level.enemyLayer.remove(zombie);
						delete opponent.level.zombieFlock.zombies[opponent.level.zombieFlock.zombies.indexOf(zombie)];
					}
				}
					
				this.state = STATE_EXPIRED;
			}
			
			if (state == STATE_EXPIRED) {
				player.level.itemLayer.remove(this);
			}
				
			// Flash when the item is about to disappear
			this.alpha = alpha_from_tick(maxCount - timeoutCount);
			
			timeoutCount++;
			if (timeoutCount >= maxCount) {
				timedOut = true;
				alpha = 0;
			}
		}
	}
}
