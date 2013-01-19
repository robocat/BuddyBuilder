package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * @author ksma
	 */
	public class Obstacle extends FlxSprite {
		[Embed(source="bed.png")] private var bedSprite : Class;
		
		public var type : String;
		
		public function Obstacle(x : uint, y : uint, type : String):void {
			super(x, y);
			
			this.type = type;
			
			if (this.type == "bed") {
				loadGraphic(bedSprite, false, false, 128, 64);
			}
			
			scale = new FlxPoint(2, 2);
		}
	}
}
