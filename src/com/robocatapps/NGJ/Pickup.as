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
		
		override public function update():void {
			super.update();
			
			timeoutCount++;
			if (timeoutCount >= maxCount) {
				timedOut = true;
			}
		}
	}
}
