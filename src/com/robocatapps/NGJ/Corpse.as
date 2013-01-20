package com.robocatapps.NGJ {
	import org.flixel.FlxSprite;
	/**
	 * @author ksma
	 */
	public class Corpse extends FlxSprite {
		[Embed(source="patient_dead.png")] private var deadSprite : Class;
		
		private var tick : uint = 0;
		
		public var gone : Boolean = false;
		
		
		public function Corpse(x : uint, y : uint) : void {
			super(x, y);
			
			loadGraphic(deadSprite, false, false, 128, 128);
		}
		
		private function alpha_from_tick(tick : uint) : Number {
			if (gone)
				return 0.0;
			
			if(tick < 435) return 0.8;
			if(tick < 440) return 0.7;
			if(tick < 445) return 0.6;
			if(tick < 450) return 0.5;
			if(tick < 455) return 0.4;
			if(tick < 460) return 0.3;
			if(tick < 465) return 0.2;
			if(tick < 470) return 0.1;
			if(tick < 475) return 0.0;
			if(tick < 476) return 0.0;
			if(tick < 477) return 0.0;
			
			return 1.0;
		}
		
		override public function update() : void {
			super.update();
			
			tick++;
			
			// Flash when the item is about to disappear
			this.alpha = alpha_from_tick(tick);
			
			if (tick > 475)
				gone = true;
		}
	}
}
