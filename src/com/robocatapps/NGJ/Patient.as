package com.robocatapps.NGJ {
	import org.flixel.FlxSprite;

	/**
	 * @author willi
	 */
	public class Patient extends FlxSprite {
		[Embed(source="patient.png")] private var sprite : Class;
		
		public function Patient(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null) {
			super(X, Y, SimpleGraphic);
			
			loadGraphic(sprite, false, false, 64, 64, false);
			
			addAnimation("stand", [0]);
			addAnimation("run", [0, 1, 2, 3, 4, 5], 10, true);
			play("run");
		}
		
		
		override public function update():void {
            super.update();
			
        }
		
	}
}
