package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * @author ksma
	 */
	public class Obstacle extends FlxSprite {
		[Embed(source="bloody_table.png")] private var bloodyTableSprite : Class;
		[Embed(source="regular_table.png")] private var tableSprite : Class;
		[Embed(source="plant.png")] private var plantSprite : Class;
		[Embed(source="sofa.png")] private var sofaSprite : Class;
		[Embed(source="stool.png")] private var stoolSprite : Class;
		[Embed(source="computer_table.png")] private var deskSprite : Class;
		
		public var type : String;
		
		public static const SOFA : String = "sofa";
		public static const BLOOD_TABLE : String = "blood_table";
		public static const TABLE : String = "table";
		public static const PLANT : String = "plant";
		public static const STOOL : String = "stool";
		public static const DESK : String = "desk";
		
		public function Obstacle(x : uint, y : uint, type : String, angle : int = 0):void {
			super(x, y);
			
			this.type = type;
			this.angle = angle;
			
			if (type == SOFA) {
				loadGraphic(sofaSprite);
			} else if (type == BLOOD_TABLE) {
				loadGraphic(bloodyTableSprite);
			} else if (type == TABLE) {
				loadGraphic(tableSprite);
			} else if (type == PLANT) {
				loadGraphic(plantSprite);
			} else if (type == STOOL) {
				loadGraphic(stoolSprite);
			} else if (type == DESK) {
				loadGraphic(deskSprite);
			}
		}
	}
}
