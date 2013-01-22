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
		
		private static const DURATION :uint = 5000;
		
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
			if (tick < 800) return 0;
			if (tick < 2400) return (tick - 800) / 1600;
			if (tick > 3400) return 1 - (tick - 3400) / 1600;
			return 1;
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
