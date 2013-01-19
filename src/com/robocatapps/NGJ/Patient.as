package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
		
		public var destination : FlxPoint;
		
		
		[Embed(source="mario.png")] private var sprite : Class;
		
		
		public function Patient(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null) {
			super(X, Y, SimpleGraphic);
			
			loadGraphic(sprite, false, false, 25, 28, false);
			
			addAnimation("stand", [0]);
			play("stand");
			
			destination = new FlxPoint();
			new_distination();
		}
		
		
		override public function update():void {
            super.update();
			
        }
		
		public function new_distination():void {
			destination.x = 10 + Math.random() * 300;
			destination.y = 10 + Math.random() * 500;
		}
		
	}
}
