package com.robocatapps.NGJ {
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
		private static const STAND   : uint = 0;
		private static const WALK    : uint = 1;
		private static const RUN     : uint = 2;
		
		
		// State
		private var animationState : uint;
		
		[Embed(source="patient.png")] private var sprite : Class;
		
		public function Patient(lvl : Level, X : Number = 0, Y : Number = 0) {
			super(X, Y);
			
			this.level = lvl;
			
			loadGraphic(sprite, false, false, 64, 64, false);
			
			addAnimation("stand", [0]);			
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			addAnimation("run", [6, 7, 8, 9], 10, true);
			play("stand");
			animationState = STAND;
			
			area = new FlxRect(level.origin.x, level.origin.y, 500, 820);
			
			destination = new FlxPoint();
			new_distination();
			
//			color = 0x07d303;
		}
		
		
		override public function update():void {
            super.update();
			
			angle = FlxU.getAngle(origin, velocity);
			
			if (Math.abs(velocity.x) == STAND_VELOCITY && Math.abs(velocity.y) == STAND_VELOCITY)
			{
				play("stand");
				animationState = STAND;
			}
			else if (Math.abs(velocity.x) == WALK_VELOCITY && Math.abs(velocity.y) == WALK_VELOCITY)
			{
				play("walk");
				animationState = WALK;
			}
			else if (Math.abs(velocity.x) == RUN_VELOCITY && Math.abs(velocity.y) == RUN_VELOCITY)
			{
				play("run");
				animationState = RUN;
			}
			
			
			timeoutCount++;
			if (animationState == RUN && timeoutCount >= 200) {
				timeoutCount = 0;
				velocity.x /= 2;
				velocity.y /= 2;
				play("walk");
				animationState = WALK;
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
						
		
			if (x < area.x + 80) {
				velocity.x *= -1;
			}
			else if (x > area.x + area.width - 80) {
				velocity.x *= -1;
			}
			
			if (y < area.y + 80) {
				velocity.y *= -1;
			}
			else if (y > area.y + area.height - 80) {
				velocity.y *= -1;
			} 
			
        }
		
		public function new_distination():void {
			destination.x = level.origin.x+40 + Math.random() * (520 - 80);
			destination.y = level.origin.y+40 + Math.random() * (800 - 80);
		}
		
	}
}
