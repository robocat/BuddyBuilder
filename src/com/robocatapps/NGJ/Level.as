package com.robocatapps.NGJ {
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
		
		// Instance vars
		public var player:Player;
		public var pickups : Array;
		public var obstacles : Array;
		public var npcs : Array;
		
		// Layout
		public var origin : FlxPoint;
		
		public function Level(player: Player, origin : FlxPoint):void {
			this.origin = origin;
			
			// Add the floor first since it needs 
			// to beneath the player
			this.addFloor();
			trace("test");
			
			// Add the player for the level
			this.player = player;
			add(this.player);
			
			this.pickups = new Array();
			this.obstacles = new Array();
			this.npcs = new Array();
		}
		
		private function addFloor():void {
			for (var i : uint = 0; i < Math.round(500 / 64); i++) {
				for (var j : uint = 0; j < 820 / 64; j++) {
					var tile : FlxSprite = new FlxSprite(this.origin.x + (i * 64),this.origin.y + (j * 64));
					tile.loadGraphic(tileSprite);
					add(tile);
				}
			}
		}
		
		
	}
}
