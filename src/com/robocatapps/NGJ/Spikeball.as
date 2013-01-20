package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class Spikeball extends FlxSprite {
		[Embed(source="spike.png")] private var sprite : Class;
		[Embed(source="spikeball.mp3")] private var sound : Class;
		
		private var group : FlxGroup;
		private var dead : Boolean = false;
		public var speed : int = 20;
		private var dir : int;
		
		public function Spikeball(x:uint, y:uint, group : FlxGroup) : void {
			super(x, y);
			loadGraphic(sprite);
			this.group = group;
			FlxG.play(sound);
			dir = Math.random() * 360;
		}
		
		public function remove() : void {
			dead = true;
			color = 0xff0000;
		}
		
		override public function update() : void {
			if (dead) group.remove(this);
			
			angle += 10;
			
			if (speed > 0) {
				speed -= 0.1;
				x += Math.sin(dir) * speed;
				y -= Math.cos(dir) * speed;
			} else {
				speed = 0;
			}
			
			var area : int = (x > 720? 1: 0);
			x = (area == 0? x > 700? 700: x < 200? 200: x: x > 1240? 1240: x < 740? 740: x);
			y = (y > 860? 860: y < 40? 40: y);
		}
	}
}
