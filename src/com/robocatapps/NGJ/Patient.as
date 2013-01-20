package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
		
		public var destination : FlxPoint;
		
		public var level : Level;
		
		// Velocity
		public static const STAND_VELOCITY   : Number = 0.0;
		public static const WALK_VELOCITY    : Number = 50.0;
		public static const RUN_VELOCITY     : Number = 100.0;
		
		
		private var area : FlxRect;
		
		private var timeoutCount : uint = 0;
		
		
		// State
		public static const STAND   : uint = 0;
		public static const WALK    : uint = 1;
		public static const RUN     : uint = 2;
		
		
		// State
		public var animationState : uint;
		
		[Embed(source="patient.png")] private var sprite : Class;
		
		public function Patient(lvl : Level, X : Number = 0, Y : Number = 0) {
			super(X, Y);
			
			this.level = lvl;
			
			loadGraphic(sprite, false, false, 64, 64, false);
			
			addAnimation("stand", [0]);			
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			addAnimation("run", [6, 7, 8, 9], 10, true);
			play("walk");
			animationState = WALK;
			
			area = new FlxRect(level.origin.x+8, level.origin.y+8, 494, 804);
			
			destination = new FlxPoint();
			new_distination();
			
//			color = 0x07d303;
		}
		
		
		override public function update():void {
            super.update();
			
			angle = FlxU.getAngle(origin, velocity);
			
			
//			// Random run
//			var random : Number = Math.abs(Math.random() * 100); 
//			if (random > 0 && random < 10)
//			{
//				velocity.x = (velocity.x > 0.0) ? Patient.RUN_VELOCITY : -Patient.RUN_VELOCITY;
//				velocity.y = (velocity.y > 0.0) ? Patient.RUN_VELOCITY : -Patient.RUN_VELOCITY;
//			}
			
			
			if (animationState != RUN) {
				if (Math.abs(velocity.x) == STAND_VELOCITY) // && Math.abs(velocity.y) == STAND_VELOCITY
				{
					play("stand");
					animationState = STAND;
				}
				else if (Math.abs(velocity.x) == WALK_VELOCITY) //  && Math.abs(velocity.y) == WALK_VELOCITY
				{
					play("walk");
					animationState = WALK;
				}
				else if (Math.abs(velocity.x) == RUN_VELOCITY) //  && Math.abs(velocity.y) == RUN_VELOCITY
				{
					play("run");
					animationState = RUN;
				}
			}
			else {
				timeoutCount++;
				if (animationState == RUN && timeoutCount >= 200) {
					timeoutCount = 0;
					velocity.x /= 2;
					velocity.y /= 2;
					play("walk");
					animationState = WALK;
				}
			}
			
			
//			var obstacle : Obstacle;
//			
//			for each (obstacle in level.obstacles) {
//				if (x + width > obstacle.x && x < obstacle.x + obstacle.width
//				&& y + height > obstacle.y && y < obstacle.y + obstacle.height)
//				{
//					FlxU.rotatePoint(x, y, x, y, 45);
//				}
//			}
						
		
			if (x < area.x) {
				velocity.x *= -1;
			}
			else if (x >= area.x + area.width - 50) {
				velocity.x *= -1;
			}
			
			if (y < area.y) {
				velocity.y *= -1;
			}
			else if (y >= area.y + area.height - 50) {
				velocity.y *= -1;
			}
        }
		
		public function new_distination():void {
			destination.x = area.x + 10 + Math.random() * (area.width - 80);
			destination.y = area.y + 10 + Math.random() * (area.height - 80);
		}
		
	}
}
