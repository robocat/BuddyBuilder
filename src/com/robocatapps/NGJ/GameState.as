package com.robocatapps.NGJ {
	import org.flixel.FlxState;
	
	public class GameState extends FlxState {
		private var player1 : Player;
		private var player2 : Player;
		
		public function GameState() : void {
			player1 = new Player(0, 100, 100);
			player2 = new Player(1, 600, 300);
			
			add(player1);
			add(player2);
		}
	}
}
