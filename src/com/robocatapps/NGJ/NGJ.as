package com.robocatapps.NGJ {
	import org.flixel.*;

	public class NGJ extends FlxGame {
		public function NGJ() {
			super(1440, 900, MenuState);
			
			FlxG.mouse.show();
		}
	}
}
