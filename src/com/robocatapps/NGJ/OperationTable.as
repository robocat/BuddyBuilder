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

			var head : FlxSprite = new FlxSprite(0, 0);
			head.loadGraphic(body0_head_sprite);
			head.x += origin.x;
			head.y += origin.y;
			add(head);

			var torso : FlxSprite = new FlxSprite(0, 0);
			torso.loadGraphic(body0_torso_sprite);
			torso.x += origin.x;
			torso.y += origin.y + 100;
			add(torso);

			var left_arm : FlxSprite = new FlxSprite(0, 0);
			left_arm.loadGraphic(body0_left_arm_sprite);
			left_arm.x += origin.x;
			left_arm.y += origin.y + 100;
			add(left_arm);

			var right_arm : FlxSprite = new FlxSprite(0, 0);
			right_arm.loadGraphic(body0_right_arm_sprite);
			right_arm.x += origin.x + 90;
			right_arm.y += origin.y + 100;
			add(right_arm);

			var left_leg : FlxSprite = new FlxSprite(0, 0);
			left_leg.loadGraphic(body0_left_leg_sprite);
			left_leg.x += origin.x;
			left_leg.y += origin.y + 100 + 200;
			add(left_leg);

			var right_leg : FlxSprite = new FlxSprite(0, 0);
			right_leg.loadGraphic(body0_right_leg_sprite);
			right_leg.x += origin.x + 90;
			right_leg.y += origin.y + 100 + 200;
			add(right_leg);

			var torso_overlay : FlxSprite = new FlxSprite(0, 0);
			torso_overlay.loadGraphic(body0_torso_overlay_sprite);
			torso_overlay.x += origin.x;
			torso_overlay.y += origin.y + 100;
			add(torso_overlay);
		}

	}
}
