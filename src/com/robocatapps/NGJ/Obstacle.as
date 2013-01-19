package com.robocatapps.NGJ {
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * @author ksma
	 */
	public class Obstacle extends FlxSprite {
		[Embed(source="bed.png")] private var bedSprite : Class;
		
		public var frame : FlxRect;
		public var type : String;
		
		private var sprite : Class;
		
		public function Obstacle(type : String):void {
			super();
			
			this.type = type;
		}
	}
}
