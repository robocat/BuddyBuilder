package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class GameState extends FlxState {
		[Embed(source="tile.png")] private var tileSprite : Class;
		
		private var player1 : Player;
		private var player2 : Player;
		
		public var pickups : Array;
		
		public function GameState() : void {
			for (var i : uint = 0; i < FlxG.width / 64; i++) {
				for (var j : uint = 0; j < FlxG.height / 64; j++) {
					var tile : FlxSprite = new FlxSprite(i * 64, j * 64);
					tile.loadGraphic(tileSprite);
					add(tile);
				}
			}
			
			pickups = new Array();
			var hitlerkage : Pickup = new Pickup(200, 200, "hitlerkage");
			add(hitlerkage);
			pickups.push(hitlerkage);
			
			player1 = new Player(1, 100, 100, this);
			player2 = new Player(0, 600, 300, this);
			
			add(player1);
			add(player2);
		}
	}
}
