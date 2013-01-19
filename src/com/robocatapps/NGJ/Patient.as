package com.robocatapps.NGJ {
	import org.flixel.*;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
		
		public var destination : FlxPoint;
		
		private var area : FlxRect;
		
		[Embed(source="mario.png")] private var sprite : Class;
		
		
		public function Patient(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null) {
			super(X, Y, SimpleGraphic);
			
			loadGraphic(sprite, false, false, 25, 28, false);
			
			addAnimation("stand", [0]);
			play("stand");
			
			area = new FlxRect(200, 40, 500, 820);
			
			destination = new FlxPoint();
			new_distination();
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
