package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class GameState extends FlxState {
		
		
		private var player1 : Player;
		private var player2 : Player;
		
		private var level1 : Level;
		private var level2 : Level;
		
		public function GameState() : void {
			
			this.player1 = new Player(1, 450, 820, this);
			this.player2 = new Player(0, 990, 820, this);
			
			this.level1 = new Level(this.player1, new FlxPoint(200, 40));
			this.level2 = new Level(this.player2, new FlxPoint(740, 40));
			
			add(this.level1);
			add(this.level2);
		}
		
		override public function update() : void {
			super.update();
			
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
			}
			
			//if (Math.random() < 0.01) {
			//	var hitlerkage : Pickup = new Pickup(Math.random() * (FlxG.width - 100) + 50, Math.random() * (FlxG.height - 100) + 50, "hitlerkage");
			//	add(hitlerkage);
			//	pickups.push(hitlerkage);
			//}
		}
	}
}
