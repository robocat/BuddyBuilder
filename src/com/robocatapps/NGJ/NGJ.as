package com.robocatapps.NGJ {
	import org.flixel.*;

	public class NGJ extends FlxGame {
		public function NGJ() {
			super(640, 512, MenuState);
			
			FlxG.mouse.show();
		}
	}
}
