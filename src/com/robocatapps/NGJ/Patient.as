package com.robocatapps.NGJ {
	import org.flixel.FlxSprite;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
		
		[Embed(source="mario.png")] private var sprite : Class;
		
		
		public function Patient(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null) {
			super(X, Y, SimpleGraphic);
			
			loadGraphic(sprite, false, false, 25, 28, false);
			
			addAnimation("stand", [0]);
			play("stand");
		}
		
		
		override public function update():void {
            super.update();
			
        }
		
	}
}
