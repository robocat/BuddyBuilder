package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * @author ksma
	 */
	public class Obstacle extends FlxSprite {
		[Embed(source="bed.png")] private var bedSprite : Class;
		[Embed(source="sofa.png")] private var sofaSprite : Class;
		
		public var type : String;
		
		public static const SOFA : String = "sofa";
		
		public function Obstacle(x : uint, y : uint, type : String):void {
			super(x, y);
			
			this.type = type;
			
			if (this.type == "bed") {
				loadGraphic(bedSprite, false, false, 128, 64);
			} else if (type == SOFA) {
				loadGraphic(sofaSprite);
			}
		}
	}
}
