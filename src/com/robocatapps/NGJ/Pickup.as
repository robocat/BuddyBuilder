package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Pickup extends FlxSprite {
		
		[Embed(source="hitlerkage.png")] private var hitlerkageSprite : Class;
		
		public function Pickup(x:uint, y:uint, type:String) : void{
			super(x, y);
			
			if (type == "hitlerkage") {
				loadGraphic(hitlerkageSprite, false, false, 22, 22, false);
				addAnimation("spin", [0, 1, 2, 3], 10, true);
				play("spin");
				scale = new FlxPoint(5, 5);
			} else if (type == "") {
				
			}
		}
	}
}
