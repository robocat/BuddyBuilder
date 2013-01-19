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

		// Masks
		public const NONE      : uint = 0;
		public const TORSO     : uint = 1;
		public const HEAD      : uint = 2;
		public const LEFT_ARM  : uint = 4;
		public const RIGHT_ARM : uint = 8;
		public const LEFT_LEG  : uint = 16;
		public const RIGHT_LEG : uint = 32;
		public const ALL       : uint = 63;
		
		// Combination of masks
		public const NON_TORSO : uint = ALL ^ TORSO;

		// State
		private var bodyMask : uint;


		private var cont : uint;
		private var scene : GameState;
		
		// Layout
		public var origin : FlxPoint;
		
		// Body parts
		private var bodyHead : FlxSprite;
		private var bodyTorso : FlxSprite;
		private var bodyTorsoOverlay : FlxSprite;
		private var bodyLeftArm : FlxSprite;
		private var bodyRightArm : FlxSprite;
		private var bodyLeftLeg : FlxSprite;
		private var bodyRightLeg : FlxSprite;
		
		public function OperationTable(controls:uint, origin : FlxPoint) : void {
			this.origin = origin;
			cont = controls;
			
			var head : FlxSprite = new FlxSprite(0, 0);
			head.loadGraphic(body0_head_sprite);
			head.x += origin.x;
			head.y += origin.y;
			add(head);
			this.bodyHead = head;

			var torso : FlxSprite = new FlxSprite(0, 0);
			torso.loadGraphic(body0_torso_sprite);
			torso.x += origin.x;
			torso.y += origin.y + 100;
			add(torso);
			this.bodyTorso = torso;

			var left_arm : FlxSprite = new FlxSprite(0, 0);
			left_arm.loadGraphic(body0_left_arm_sprite);
			left_arm.x += origin.x;
			left_arm.y += origin.y + 100;
			add(left_arm);
			this.bodyLeftArm = left_arm;

			var right_arm : FlxSprite = new FlxSprite(0, 0);
			right_arm.loadGraphic(body0_right_arm_sprite);
			right_arm.x += origin.x + 90;
			right_arm.y += origin.y + 100;
			add(right_arm);
			this.bodyRightArm = right_arm;

			var left_leg : FlxSprite = new FlxSprite(0, 0);
			left_leg.loadGraphic(body0_left_leg_sprite);
			left_leg.x += origin.x;
			left_leg.y += origin.y + 100 + 200;
			add(left_leg);
			this.bodyLeftLeg = left_leg;

			var right_leg : FlxSprite = new FlxSprite(0, 0);
			right_leg.loadGraphic(body0_right_leg_sprite);
			right_leg.x += origin.x + 90;
			right_leg.y += origin.y + 100 + 200;
			add(right_leg);
			this.bodyRightLeg = right_leg;

			var torso_overlay : FlxSprite = new FlxSprite(0, 0);
			torso_overlay.loadGraphic(body0_torso_overlay_sprite);
			torso_overlay.x += origin.x;
			torso_overlay.y += origin.y + 100;
			add(torso_overlay);
			this.bodyTorsoOverlay = torso_overlay;
			
			
			
			this.reset_body();
			
			this.add_to_body(HEAD);
			this.add_to_body(TORSO);
			this.add_to_body(LEFT_ARM);
			this.add_to_body(RIGHT_LEG);
		}

		public function reset_body() : void {
			this.bodyMask = NONE;
			this.set_body_visibility(this.bodyMask);
		}

		public function add_to_body(mask : uint) : void {
			this.bodyMask |= mask;
			this.set_body_visibility(this.bodyMask);
		}

		private function set_body_visibility(mask : uint) : void {
			this.bodyTorso.visible        = (mask & TORSO    ) != 0;
			this.bodyHead.visible         = (mask & HEAD     ) != 0;
			this.bodyLeftArm.visible      = (mask & LEFT_ARM ) != 0;
			this.bodyRightArm.visible     = (mask & RIGHT_ARM) != 0;
			this.bodyLeftLeg.visible      = (mask & LEFT_LEG ) != 0;
			this.bodyRightLeg.visible     = (mask & RIGHT_LEG) != 0;
			this.bodyTorsoOverlay.visible = ((mask & NON_TORSO) != 0) && ((mask & TORSO    ) != 0);
		}

	}
}
