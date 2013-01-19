package com.robocatapps.NGJ {
	import org.flixel.*;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
<<<<<<< HEAD
		
		public var destination : FlxPoint;
		
		private var area : FlxRect;
		
		[Embed(source="mario.png")] private var sprite : Class;
		
=======
		[Embed(source="patient.png")] private var sprite : Class;
>>>>>>> 3a78be9850d0afde6bfb0ec0a8cea712d666f171
		
		public function Patient(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null) {
			super(X, Y, SimpleGraphic);
			
			loadGraphic(sprite, false, false, 64, 64, false);
			
			addAnimation("stand", [0]);
<<<<<<< HEAD
			play("stand");
			
			area = new FlxRect(200, 40, 500, 820);
			
			destination = new FlxPoint();
			new_distination();
=======
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			addAnimation("run", [6, 7, 8, 9], 10, true);
			play("walk");
>>>>>>> 3a78be9850d0afde6bfb0ec0a8cea712d666f171
		}
		
		
		override public function update():void {
            super.update();
			
		
			if (x < area.x + 10) {
				velocity.x *= -1;
			}
			else if (x > area.x + area.width - 10) {
				velocity.x *= -1;
			}
			
			if (y < area.y + 10) {
				velocity.y *= -1;
			}
			else if (y > area.y + area.height - 10) {
				velocity.y *= -1;
			} 
			
        }
		
		public function new_distination():void {
			destination.x = 220 + Math.random() * (480 - 220);
			destination.y = 60 + Math.random() * (800 - 60);
		}
		
	}
}
