package com.robocatapps.NGJ {
	import flash.sensors.Accelerometer;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Pickup extends FlxSprite {
		
		[Embed(source="light_pickup.png")] private var lightSprite : Class;
		[Embed(source="speed_pickup.png")] private var swapSprite : Class;
		[Embed(source="swap_pickup.png")] private var speedSprite : Class;
		[Embed(source="zombie_pickup.png")] private var zombieSprite : Class;
		
		
		[Embed(source="left_leg_drop.png")] private var leftLegSprite : Class;
		[Embed(source="right_leg_drop.png")] private var rightLegSprite : Class;
		[Embed(source="left_arm_drop.png")] private var leftArmSprite : Class;
		[Embed(source="right_arm_drop.png")] private var rightArmSprite : Class;
		[Embed(source="head_drop.png")] private var headSprite : Class;
		[Embed(source="torso_drop.png")] private var torsoSprite : Class;
		
		public static const DROP_LIGHT : String = "light";
		public static const DROP_SPEED : String = "speed";
		public static const DROP_SWAP : String = "swap";
		public static const DROP_ZOMBIE : String = "zombie";
		
		
		public static const DROP_LEFTLEG : String = "left_leg";
		public static const DROP_RIGHTLEG : String = "right_leg";
		public static const DROP_LEFTARM : String = "left_arm";
		public static const DROP_RIGHTARM : String = "right_arm";
		public static const DROP_HEAD : String = "head";
		public static const DROP_TORSO : String = "torso";
		
		public static const DROP_TYPES : Array = [DROP_ZOMBIE, DROP_SWAP, DROP_SPEED, DROP_LIGHT, DROP_LEFTLEG, DROP_RIGHTLEG, DROP_LEFTARM, DROP_RIGHTARM, DROP_HEAD, DROP_TORSO];
		public static const DROP_NAMES : Array = ["ZOMBIE", "SWAP", "SPEED", "DARKNESS", "LEFT LEG", "RIGHT LEG", "LEFT ARM", "RIGHT ARM", "HEAD", "TORSO"];
		
		public var type : String;
		public var sprite : Class;
		
		public var timeoutCount : uint = 0;
		public var maxCount : uint = 300;
		
		public var timedOut : Boolean = false;
		
		private var speed : uint = 0;
		private var area : uint = 0;
		
		public function Pickup(x:uint, y:uint, type:String, speed:uint = 0, angle:int = 0) : void{
			super(x, y);
			this.speed = speed;
			this.angle = angle;
			
			area = (x > 720? 1: 0);
			
			this.type = type;
			
			if (type == DROP_LIGHT) {
				loadGraphic(lightSprite, false, false, 48, 52, false);
				sprite = lightSprite;
			} else if (type == DROP_SPEED) {
				loadGraphic(speedSprite, false, false, 48, 52, false);
				sprite = speedSprite;
			} else if (type == DROP_SWAP) {
				loadGraphic(swapSprite, false, false, 48, 52, false);
				sprite = swapSprite;
			} else if (type == DROP_ZOMBIE) {
				loadGraphic(zombieSprite, false, false, 48, 52, false);
				sprite = zombieSprite;
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
				loadGraphic(headSprite, false, false, 40, 44, false);
				sprite = headSprite;
			} else if (type == DROP_TORSO) {
				loadGraphic(torsoSprite, false, false, 72, 110, false);
				sprite = torsoSprite;
			} else {
				trace('lol ' + type);
			}
			
		}
		
		public function is_body_part() : Boolean {
			return 	this.type != DROP_LIGHT &&
					this.type != DROP_SPEED &&
					this.type != DROP_SWAP &&
					this.type != DROP_ZOMBIE;
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
		
		public function apply(player : Player) : void {
			if (type == DROP_LIGHT) {
				player.level.getOpponent().level.turnOffLights();
			} else {
				var part : uint = this.to_body_part();
				if (player.level.operation_table.can_add_to_body(part)) {
					new HUDSprite(sprite, player.playernumber, text_for_pickup(), player.level.gameState.textLayer);
					player.level.operation_table.add_to_body(this.to_body_part());
				}
				
				
			}
		}

		private function alpha_from_tick(tick : uint) : Number {
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
			return 1.0;
		}
		
		override public function update():void {
			super.update();
			
			if (speed > 0) {
				speed -= 0.1;
				x += Math.sin(angle) * speed;
				y -= Math.cos(angle) * speed;
				
				x = (area == 0? x > 700? 700: x < 200? 200: x: x > 1240? 1240: x < 740? 740: x);
				y = (y > 860? 860: y < 40? 40: y);
				
			}
			
			// Flash when the item is about to disappear
			this.alpha = alpha_from_tick(maxCount - timeoutCount);
			
			timeoutCount++;
			if (timeoutCount >= maxCount) {
				timedOut = true;
			}
		}
	}
}
