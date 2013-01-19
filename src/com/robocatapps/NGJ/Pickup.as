package com.robocatapps.NGJ {
	import flash.sensors.Accelerometer;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Pickup extends FlxSprite {
		
		[Embed(source="hitlerkage.png")] private var hitlerkageSprite : Class;
		[Embed(source="left_leg_drop.png")] private var leftLegSprite : Class;
		[Embed(source="right_leg_drop.png")] private var rightLegSprite : Class;
		[Embed(source="left_arm_drop.png")] private var leftArmSprite : Class;
		[Embed(source="right_arm_drop.png")] private var rightArmSprite : Class;
		[Embed(source="head_drop.png")] private var headSprite : Class;
		[Embed(source="torso_drop.png")] private var torsoSprite : Class;
		
		public static const DROP_LIGHT : String = "hitlerkage";
		public static const DROP_LEFTLEG : String = "left_leg";
		public static const DROP_RIGHTLEG : String = "right_leg";
		public static const DROP_LEFTARM : String = "left_arm";
		public static const DROP_RIGHTARM : String = "right_arm";
		public static const DROP_HEAD : String = "head";
		public static const DROP_TORSO : String = "torso";
		
		public var type : String;
		
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
				loadGraphic(hitlerkageSprite, false, false, 22, 22, false);
				addAnimation("spin", [0, 1, 2, 3], 10, true);
				play("spin");
				scale = new FlxPoint(2, 2);
			} else if (type == DROP_LEFTLEG) {
				loadGraphic(leftLegSprite, false, false, 26, 57, false);
			} else if (type == DROP_RIGHTLEG) {
				loadGraphic(rightLegSprite, false, false, 26, 58, false);
			} else if (type == DROP_LEFTARM) {
				loadGraphic(leftArmSprite, false, false, 22, 40, false);
			} else if (type == DROP_RIGHTARM) {
				loadGraphic(rightArmSprite, false, false, 23, 41, false);
			} else if (type == DROP_HEAD) {
				loadGraphic(headSprite, false, false, 40, 44, false);
			} else if (type == DROP_TORSO) {
				loadGraphic(torsoSprite, false, false, 36, 55, false);
			}
			
		}
		
		public function apply(player : Player) : void {
			if (type == DROP_LEFTLEG) {
				player.level.operation_table.add_to_body(OperationTable.LEFT_LEG);
			} else if (type == DROP_RIGHTLEG) {
				player.level.operation_table.add_to_body(OperationTable.RIGHT_LEG);
			} else if (type == DROP_LEFTARM) {
				player.level.operation_table.add_to_body(OperationTable.LEFT_ARM);
			} else if (type == DROP_RIGHTARM) {
				player.level.operation_table.add_to_body(OperationTable.RIGHT_ARM);
			} else if (type == DROP_HEAD) {
				player.level.operation_table.add_to_body(OperationTable.HEAD);
			} else if (type == DROP_TORSO) {
				player.level.operation_table.add_to_body(OperationTable.TORSO);
			} else if (type == DROP_LIGHT) {
				player.level.getOpponent().level.turnOffLights();
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
