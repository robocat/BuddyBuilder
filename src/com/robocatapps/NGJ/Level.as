package com.robocatapps.NGJ {
	import org.flixel.FlxRect;
	import flash.trace.Trace;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	/**
	 * @author ksma
	 */
	public class Level extends FlxGroup {
		// Sprites
		[Embed(source="tile.png")] private var tileSprite : Class;
		[Embed(source="floor.png")] private var floorSprite : Class;
		[Embed(source="light_mask.png")] private var lightSprite : Class;
		
		// Instance vars
		public var player:Player;
		public var pickups : Array;
		public var obstacles : Array;
		public var npcs : Array;
		
		// Layout
		public var origin : FlxPoint;
		
		// Effects
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		public function Level(player: Player, origin : FlxPoint):void {
			this.pickups = new Array();
			this.obstacles = new Array();
			this.npcs = new Array();
			
			this.origin = origin;
			
			// Add the floor first since it needs 
			// to beneath the player
			this.addFloor();
			
			// Add obstacles to the level
			this.addObstacles();
			
			// Add the player for the level
			this.player = player;

			add(this.player);
			
			// Add the light sprite for flickering
			this.light = new FlxSprite(this.origin.x, this.origin.y, lightSprite);
			add(this.light);
		}
		
		private function addFloor():void {
			//for (var i : uint = 0; i < Math.round(500 / 64); i++) {
			//	for (var j : uint = 0; j < 820 / 64; j++) {
			//		var tile : FlxSprite = new FlxSprite(this.origin.x + (i * 64),this.origin.y + (j * 64));
			//		tile.loadGraphic(tileSprite);
			//		add(tile);
			//	}
			//}
			var floor : FlxSprite = new FlxSprite(this.origin.x, this.origin.y, floorSprite);
			floor.loadGraphic(floorSprite);
			add(floor);
		}
		
		private function addObstacles():void {
			this.obstacles.push(new Obstacle(this.origin.x + 40, this.origin.y + 40, "bed"));
			
			for each (var obstacle : Obstacle in this.obstacles) {
				add(obstacle);
			}
		}
		
		override public function update():void {
			super.update();
			
			if ((light_counter++) > Math.random() * 100) {
				light_counter = 0;
				light.alpha = Math.random() * 0.25 + 0.25;
			}
		}
	}
}
