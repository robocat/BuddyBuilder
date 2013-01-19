package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Blood extends FlxSprite {
		[Embed(source="blood.png")] private var bloodSprite : Class;
		
		private var speed : int = 10.0;
		
		public function Blood(x:uint, y:uint) : void {
			super(x, y);
			loadGraphic(bloodSprite);
			angle = Math.random() * 360;
			scale = new FlxPoint(3, 3);
		}
		
		override public function update() : void {
			speed -= 0.1;
			
			if (speed < 0.1) return;
			
			x += Math.sin(angle) * speed;
			y -= Math.cos(angle) * speed;
		}
	}
}
