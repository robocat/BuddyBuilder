package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Blood extends FlxSprite {
		[Embed(source="blood1.png")] private var bloodSprite1 : Class;
		[Embed(source="blood2.png")] private var bloodSprite2 : Class;
		[Embed(source="blood3.png")] private var bloodSprite3 : Class;
		[Embed(source="blood4.png")] private var bloodSprite4 : Class;
		[Embed(source="blood5.png")] private var bloodSprite5 : Class;
		[Embed(source="blood6.png")] private var bloodSprite6 : Class;
		[Embed(source="blood7.png")] private var bloodSprite7 : Class;
		[Embed(source="blood8.png")] private var bloodSprite8 : Class;
		[Embed(source="blood9.png")] private var bloodSprite9 : Class;
		[Embed(source="blood10.png")] private var bloodSprite10 : Class;
		
		private var speed : int = 10.0;
		
		public function Blood(x:uint, y:uint) : void {
			super(x, y);
			var i : int = Math.random() * 10;
			if (i == 0) loadGraphic(bloodSprite1);
			if (i == 1) loadGraphic(bloodSprite2);
			if (i == 2) loadGraphic(bloodSprite3);
			if (i == 3) loadGraphic(bloodSprite4);
			if (i == 4) loadGraphic(bloodSprite5);
			if (i == 5) loadGraphic(bloodSprite6);
			if (i == 6) loadGraphic(bloodSprite7);
			if (i == 7) loadGraphic(bloodSprite8);
			if (i == 8) loadGraphic(bloodSprite9);
			if (i == 9) loadGraphic(bloodSprite10);
			angle = Math.random() * 360;
		}
		
		override public function update() : void {
			speed -= 0.1;
			
			if (speed < 0.1) return;
			
			x += Math.sin(angle) * speed;
			y -= Math.cos(angle) * speed;
		}
	}
}
