package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Pickup extends FlxSprite {
		
		[Embed(source="hitlerkage.png")] private var hitlerkageSprite : Class;
		
		public var timeoutCount : uint = 0;
		public var maxCount : uint = 300;
		
		public var timedOut : Boolean = false;
		
		public function Pickup(x:uint, y:uint, type:String) : void{
			super(x, y);
			
			if (type == "hitlerkage") {
				loadGraphic(hitlerkageSprite, false, false, 22, 22, false);
				addAnimation("spin", [0, 1, 2, 3], 10, true);
				play("spin");
				scale = new FlxPoint(2, 2);
			} else if (type == "") {
				
			}
		}

		private function alpha_from_tick(tick : uint) : Number {
			if(tick < 2) return 0.2;
			if(tick < 5) return 0.3;
			if(tick < 8) return 0.8;
			if(tick < 10) return 1.0;
			if(tick < 12) return 0.3;
			if(tick < 15) return 1.0;
			if(tick < 20) return 0.8;
			if(tick < 25) return 1.0;
			if(tick < 30) return 0.8;
			if(tick < 55) return 1.0;
			if(tick < 60) return 0.8;
			if(tick < 85) return 1.0;
			if(tick < 90) return 0.8;
			return 1.0;
		}
		
		override public function update():void {
			super.update();
			
			// Flash when the item is about to disappear
			this.alpha = alpha_from_tick(maxCount - timeoutCount);
			
			timeoutCount++;
			if (timeoutCount >= maxCount) {
				timedOut = true;
			}
		}
	}
}
