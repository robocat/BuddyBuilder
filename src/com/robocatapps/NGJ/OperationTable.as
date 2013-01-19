package com.robocatapps.NGJ {
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * @author neoneye
	 */
	public class OperationTable extends FlxGroup {
		[Embed(source="body0_head.png")] private var body0_head_sprite : Class;
		[Embed(source="body0_torso.png")] private var body0_torso_sprite : Class;
		[Embed(source="body0_torso_overlay.png")] private var body0_torso_overlay_sprite : Class;
		[Embed(source="body0_left_arm.png")] private var body0_left_arm_sprite : Class;
		[Embed(source="body0_right_arm.png")] private var body0_right_arm_sprite : Class;
		[Embed(source="body0_left_leg.png")] private var body0_left_leg_sprite : Class;
		[Embed(source="body0_right_leg.png")] private var body0_right_leg_sprite : Class;

		private var cont : uint;
		private var scene : GameState;
		
		// Layout
		public var origin : FlxPoint;
		
		public function OperationTable(controls:uint, origin : FlxPoint) : void {
			this.origin = origin;
			cont = controls;
			//loadGraphic(body0_head_sprite, false, false, 180, 100, false);
			//loadGraphic(body0_torso_sprite, false, false, 180, 200, false);
			//loadGraphic(body0_torso_overlay_sprite, false, false, 180, 200, false);
		}

	}
}
