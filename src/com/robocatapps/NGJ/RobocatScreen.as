package com.robocatapps.NGJ {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.utils.getTimer;
	
	/**
	 * @author ksma
	 */
	public class RobocatScreen extends FlxState {
		[Embed(source="robocat.png")] private var robocatSprite : Class;
		[Embed(source="Meow.mp3")] private var meowSound : Class;
		
		private static const DURATION :uint = 3600;
		
		private var robocatLogo : FlxSprite;
		private var meowPlayed : Boolean = false;
		
		private var tick : uint = 0;
		private var start : uint = 0;
		
		public function RobocatScreen() : void {
			add(robocatLogo = new FlxSprite((FlxG.width - 294) / 2, (FlxG.height - 319) / 2));
			robocatLogo.alpha = 0.0;
			robocatLogo.loadGraphic(robocatSprite);
			
			
		}
		
		private function alphaFromTick() : Number {
			if (tick < 150) return 0.1;
			if (tick < 300) return 0.2;
			if (tick < 450) return 0.3;
			if (tick < 600) return 0.4;
			if (tick < 750) return 0.5;
			if (tick < 900) return 0.6;
			if (tick < 1050) return 0.7;
			if (tick < 1300) return 0.8;
			if (tick < 1450) return 0.9;
			if (tick < 1600) return 1.0;
			
			if (tick < 2000) return 0.9;
			if (tick < 2150) return 0.8;
			if (tick < 2300) return 0.7;
			if (tick < 2450) return 0.6;
			if (tick < 2600) return 0.5;
			if (tick < 2750) return 0.4;
			if (tick < 2900) return 0.3;
			if (tick < 3150) return 0.2;
			if (tick < 3300) return 0.1;
			if (tick < 3450) return 0.0;

			
			
			
			return 0.0;
		}
		
		override public function update() : void {
			super.update();
			
			tick = getTimer();
			if (start == 0)
				start = tick;
			
			robocatLogo.alpha = alphaFromTick();
			
			if (!meowPlayed && tick >= 1450) {
				FlxG.play(meowSound);
				meowPlayed = true;
			}
			
			if (tick >= DURATION) {
				 FlxG.switchState(new MenuState());
			}
		}
	}
}
