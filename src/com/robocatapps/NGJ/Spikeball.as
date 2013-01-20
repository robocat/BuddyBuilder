package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class Spikeball extends FlxSprite {
		[Embed(source="spike.png")] private var sprite : Class;
		[Embed(source="spikeball.mp3")] private var sound : Class;
		
		private var group : FlxGroup;
		private var dead : Boolean = false;
		public var speed : int = 20;
		
		public function Spikeball(x:uint, y:uint, group : FlxGroup) : void {
			super(x, y);
			loadGraphic(sprite);
			this.group = group;
			FlxG.play(sound);
			angle = Math.random() * 360;
		}
		
		public function remove() : void {
			dead = true;
			color = 0xff0000;
		}
		
		override public function update() : void {
			if (dead) group.remove(this);
			
			if (speed > 0) {
				speed -= 0.1;
				x += Math.sin(angle) * speed;
				y -= Math.cos(angle) * speed;
			} else {
				speed = 0;
			}
		}
	}
}
