package com.robocatapps.NGJ {
	import flash.display.Sprite;
	import org.flixel.*;
	
	public class GameState extends FlxState {
		[Embed(source="bed.png")] private var bedSprite : Class;
		[Embed(source="light.png")] private var lightSprite : Class;
		[Embed(source="level_grid.png")] private var gridSprite : Class;
		[Embed(source="tile.png")] private var body0torso : Class;
		
		// STATE
		public static const STATE_COUNTDOWN :uint = 1;
		public static const STATE_PLAYING :uint = 2;
		public static const STATE_GAMEOVER :uint = 3;
		public static const STATE_PAUSED :uint = 4;
		
		public var state : uint;
		
		private var player0 : Player;
		private var player1 : Player;
		
		private var level0 : Level;
		private var level1 : Level;
		
		private var operation_table0 : OperationTable;
		private var operation_table1 : OperationTable;
		
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		private var levelLayer : FlxGroup;
		private var textLayer : FlxGroup;
		
		private var pausedText : FlxText;
		private var overlay : FlxSprite;
		
		public function GameState() : void {
			this.levelLayer = new FlxGroup();
			this.textLayer = new FlxGroup();
			
			this.add(this.levelLayer);
			this.add(this.textLayer)
			
			var grid : FlxSprite = new FlxSprite(0, 0);
			grid.loadGraphic(gridSprite);
			this.levelLayer.add(grid);
			
			this.operation_table0 = new OperationTable(0, new FlxPoint(20, 106));
			this.operation_table1 = new OperationTable(1, new FlxPoint(1261, 106));
			
			this.player0 = new Player(0);
			this.player1 = new Player(1);
			
			this.level0 = new Level(this.player0, new FlxPoint(209, 50), this.operation_table0, this);
			this.level1 = new Level(this.player1, new FlxPoint(739, 50), this.operation_table1, this);
			
			player0.level = level0;
			player1.level = level1;
			
			this.levelLayer.add(this.level0);
			this.levelLayer.add(this.level1);
			
			this.levelLayer.add(this.operation_table0);
			this.levelLayer.add(this.operation_table1);
			
			
			// HUD: Player

			{
				var txt0 : FlxText = new FlxText(20,39,180, "DOCTOR 1");
				txt0.setFormat("Heading", 30, 0xffffffff, "left");
				this.levelLayer.add(txt0);
			}
			{
				var txt1 : FlxText = new FlxText(1261,39,180, "DOCTOR 2");
				txt1.setFormat("Heading", 30, 0xffffffff, "left");
				this.levelLayer.add(txt1);
			}
			{
				var sub0 : FlxText = new FlxText(18,79,181, "Wozniacki");
				sub0.setFormat("Subtext", 16, 0x3bd9d8ff, "left");
				this.levelLayer.add(sub0);
			}
			{
				var sub1 : FlxText = new FlxText(1259,79,181, "Tsurenko");
				sub1.setFormat("Subtext", 16, 0x1fc89aff, "left");
				this.levelLayer.add(sub1);
			}
			{
				this.overlay = new FlxSprite(0, 0);
				this.overlay.makeGraphic(FlxG.width, FlxG.height);
				this.overlay.color = 0x000000;
				this.overlay.alpha = 0;
			
				this.textLayer.add(overlay);
			}
			{
				this.pausedText = new FlxText(460, 300, 500, "PAUSED");
				this.pausedText.setFormat("Subtext",80, 0xFFFFFF, "center");
				this.pausedText.alpha = 0;
				this.textLayer.add(this.pausedText);
			}
			
			
			this.state = STATE_PLAYING;
		}
		
		override public function update() : void {
			super.update();
			
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
			}
			
			if (FlxG.keys.justPressed("P")) {
				if (this.state == STATE_PAUSED) {
					this.state = STATE_PLAYING;
				} else {
					this.state = STATE_PAUSED;
				}
			}
			
			if (this.state == STATE_PAUSED) {
				this.overlay.alpha = 0.5;
				this.pausedText.alpha = 1;
			} else if (this.state == GameState.STATE_PLAYING) {
				this.overlay.alpha = 0;
				this.pausedText.alpha = 0;
			}
			
			if (this.state == GameState.STATE_PLAYING) {
				if (this.level0.operation_table.complete()) {
					this.gameOver(this.level0.player);
				} else if (this.level1.operation_table.complete()) {
					this.gameOver(this.level1.player);
				}	
			}
		}
		
		private function gameOver(winner : Player) : void {
			this.state = STATE_GAMEOVER;
			
			this.overlay.alpha = 0.5;
			
			{
				var txt0 : FlxText = new FlxText(416,250,1024, "GAME OVER");
				txt0.setFormat("Heading", 140, 0xffffffff, "left");
				this.textLayer.add(txt0);
			}
			
			{
				var txt1 : FlxText = new FlxText(416,450,1024, "DOCTOR " + (winner.playernumber + 1) + " WINS");
				txt1.setFormat("Heading", 104, 0xffffffff, "left");
				this.textLayer.add(txt1);
			}
		}
		
		public function getOpponnent(player : Player):Player {
			if (player == this.player0){
				return this.player1;
			} else {
				return this.player0;
			}
		}
	}
}
