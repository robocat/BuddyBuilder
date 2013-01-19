package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class GameState extends FlxState {
		[Embed(source="bed.png")] private var bedSprite : Class;
		[Embed(source="light.png")] private var lightSprite : Class;
		[Embed(source="level_grid.png")] private var gridSprite : Class;
		
		private var player1 : Player;
		private var player2 : Player;
		
		private var level1 : Level;
		private var level2 : Level;
		
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		public function GameState() : void {
			var grid : FlxSprite = new FlxSprite(0, 0);
			grid.loadGraphic(gridSprite);
			add(grid);

			this.player1 = new Player(1);
			this.player2 = new Player(0);
			
			this.level1 = new Level(this.player1, new FlxPoint(200, 40));
			this.level2 = new Level(this.player2, new FlxPoint(740, 40));
			
			player1.level = level1;
			player2.level = level2;
			
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
			
			//if ((light_counter++) > Math.random() * 100) {
			//	light_counter = 0;
			//	light.alpha = Math.random() * 0.25 + 0.25;
			//}
		}
	}
}
