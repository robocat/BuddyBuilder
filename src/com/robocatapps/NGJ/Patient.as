package com.robocatapps.NGJ {
	import org.flixel.*;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
		
		public var destination : FlxPoint;
		
		public var level : Level;
		
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
			
			color = 0x07d303;
		}
		
		
		override public function update():void {
            super.update();
			
			angle = FlxU.getAngle(origin, velocity);
			
			if (Math.abs(velocity.x) >= 0.0 && Math.abs(velocity.x) <= 0.1
					&& Math.abs(velocity.y) >= 0.0 && Math.abs(velocity.y) <= 0.1)
			{
				play("stand");
				animationState = STAND;
			}
			else if (Math.abs(velocity.x) > 0.1 && Math.abs(velocity.x) <= 30
					&& Math.abs(velocity.y) > 0.1 && Math.abs(velocity.y) <= 30)
			{
				play("walk");
				animationState = WALK;
			}
			else if (Math.abs(velocity.x) > 30 && Math.abs(velocity.y) > 30)
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
