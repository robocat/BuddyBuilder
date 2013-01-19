package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * @author ksma
	 */
	public class Obstacle extends FlxSprite {
		[Embed(source="bloody_table.png")] private var bloodyTableSprite : Class;
		[Embed(source="regular_table.png")] private var bedSprite : Class;
		[Embed(source="plant.png")] private var plantSprite : Class;
		[Embed(source="sofa.png")] private var sofaSprite : Class;
		[Embed(source="stool.png")] private var stoolSprite : Class;
		
		public var type : String;
		
		public static const SOFA : String = "sofa";
		public static const BLOOD_TABLE : String = "blood_table";
		public static const TABLE : String = "table";
		public static const PLANT : String = "plant";
		public static const STOOL : String = "stool";
		
		public function Obstacle(x : uint, y : uint, type : String):void {
			super(x, y);
			
			this.type = type;
			
			if (this.type == "bed") {
				loadGraphic(bedSprite, false, false, 128, 64);
			} else if (type == SOFA) {
				loadGraphic(sofaSprite);
			}
		}
	}
}
