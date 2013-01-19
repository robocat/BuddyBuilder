package com.robocatapps.NGJ {
	import org.flixel.*;

	public class NGJ extends FlxGame {
		[Embed(source="font_heading.ttf", fontFamily="Heading", embedAsCFF="false")] public var fontHeading:String;
		[Embed(source="font_subtext.ttf", fontFamily="Subtext", embedAsCFF="false")] public var fontSubtext:String;
		
		public function NGJ() {
			super(1440, 900, MenuState);
			
			FlxG.mouse.show();
		}
	}
}
