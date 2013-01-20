package com.robocatapps.NGJ {
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class Spikeball extends FlxSprite {
		[Embed(source="spike.png")] private var sprite : Class;
		
		private var group : FlxGroup;
		private var dead : Boolean = false;
		
		public function Spikeball(x:uint, y:uint, group : FlxGroup) : void {
			super(x, y);
			loadGraphic(sprite);
			this.group = group;
		}
		
		public function remove() : void {
			dead = true;
			color = 0xff0000;
		}
		
		override public function update() : void {
			if (dead) group.remove(this);
		}
	}
}
