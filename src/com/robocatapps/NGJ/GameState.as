package com.robocatapps.NGJ {
	import flash.display.Sprite;
	import org.flixel.*;
	
	public class GameState extends FlxState {
		[Embed(source="bed.png")] private var bedSprite : Class;
		[Embed(source="level_grid.png")] private var gridSprite : Class;
		[Embed(source="holy_gloss.mp3")] private var music : Class;
		[Embed(source="loop.mp3")] private var loop : Class;
		[Embed(source="fullheart.png")] private var fullheart : Class;
		[Embed(source="emptyheart.png")] private var emptyheart : Class;
		[Embed(source="doctor1win.mp3")] private var doc1win : Class;
		[Embed(source="doctor2wins.mp3")] private var doc2win : Class;
		[Embed(source="player2.png")] private var player2controls : Class;
		[Embed(source="player1.png")] private var player1controls : Class;
		[Embed(source="build.mp3")] private var buildsound : Class;
		[Embed(source="getready.mp3")] private var getreadysound : Class;
		
		public static const PLAYER_NAMES : Array = ["Damm", "Wu", "Flarup", "Strandgaard", "Weyreuther", "Andersen", "Bruckhoff"];
		
		// STATE
		public static const STATE_COUNTDOWN :uint = 1;
		public static const STATE_PLAYING :uint = 2;
		public static const STATE_GAMEOVER :uint = 3;
		public static const STATE_PAUSED :uint = 4;
		
		public var state : uint;
		
		public var player0 : Player;
		public var player1 : Player;
		
		private var level0 : Level;
		private var level1 : Level;
		
		private var patient1 : Patient;
		
		private var flock_group:FlxGroup;
		private var flock:Flock;
		
		private var operation_table0 : OperationTable;
		private var operation_table1 : OperationTable;
		
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		public var levelLayer : FlxGroup;
		public var textLayer : FlxGroup;
		
		private var pausedText : FlxText;
		private var overlay : FlxSprite;
		
		public var p1heart1 : FlxSprite;
		public var p1heart2 : FlxSprite;
		public var p1heart3 : FlxSprite;
		public var p1heart4 : FlxSprite;
		public var p2heart1 : FlxSprite;
		public var p2heart2 : FlxSprite;
		public var p2heart3 : FlxSprite;
		public var p2heart4 : FlxSprite;
		public var p1heart1empty : FlxSprite;
		public var p1heart2empty : FlxSprite;
		public var p1heart3empty : FlxSprite;
		public var p1heart4empty : FlxSprite;
		public var p2heart1empty : FlxSprite;
		public var p2heart2empty : FlxSprite;
		public var p2heart3empty : FlxSprite;
		public var p2heart4empty : FlxSprite;
		

		public var wincountdown1 : int = -1;
		public var wincountdown2 : int = -1;
		
		private var player1controlsprite : FlxSprite;
		private var player2controlsprite : FlxSprite;
		private var getready : FlxText;
		public var getreadycountdown : int = 300;

		public var p0Effect1 : FlxSprite;
		public var p0Effect2 : FlxSprite;
		public var p0Effect3 : FlxSprite;
		public var p0Effect4 : FlxSprite;
		
		public var p1Effect1 : FlxSprite;
		public var p1Effect2 : FlxSprite;
		public var p1Effect3 : FlxSprite;
		public var p1Effect4 : FlxSprite;
		
		public var p0Effect1Timer : FlxText;
		public var p0Effect2Timer : FlxText;
		public var p0Effect3Timer : FlxText;
		public var p0Effect4Timer : FlxText;
		
		public var p1Effect1Timer : FlxText;
		public var p1Effect2Timer : FlxText;
		public var p1Effect3Timer : FlxText;
		public var p1Effect4Timer : FlxText;
		
		public var p0EffectSlots : Array = [p0Effect1, p0Effect2, p0Effect3, p0Effect4];
		public var p0TimerSlots : Array = [p0Effect1Timer, p0Effect2Timer, p0Effect3Timer, p0Effect4Timer];
		
		public var p1EffectSlots : Array = [p1Effect1, p1Effect2, p1Effect3, p1Effect4];
		public var p1TimerSlots : Array = [p1Effect1Timer, p1Effect2Timer, p1Effect3Timer, p1Effect4Timer];
		
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
			
			var shuffledNames : Array = [];
			while (PLAYER_NAMES.length > 0) {
 			   shuffledNames.push(PLAYER_NAMES.splice(Math.round(Math.random() * (PLAYER_NAMES.length - 1)), 1)[0]);
			}

			var player0title : FlxText = new FlxText(20,39,180, "DOCTOR 1");
			player0title.setFormat("Heading", 30, 0xffffffff, "left");
			this.levelLayer.add(player0title);

			var player1title : FlxText = new FlxText(1261,39,180, "DOCTOR 2");
			player1title.setFormat("Heading", 30, 0xffffffff, "left");
			this.levelLayer.add(player1title);

			var player0name : FlxText = new FlxText(18,79,181, shuffledNames[0]);
			player0name.setFormat("Subtext", 16, 0x3bd9d8ff, "left");
			this.levelLayer.add(player0name);

			var player1name : FlxText = new FlxText(1259,79,181, shuffledNames[1]);
			player1name.setFormat("Subtext", 16, 0x1fc89aff, "left");
			this.levelLayer.add(player1name);
			
			add(p1heart1empty = new FlxSprite(22 + 0 * 40, 430));
			p1heart1empty.loadGraphic(emptyheart);
			add(p1heart2empty = new FlxSprite(22 + 1 * 40, 430));
			p1heart2empty.loadGraphic(emptyheart);
			add(p1heart3empty = new FlxSprite(22 + 2 * 40, 430));
			p1heart3empty.loadGraphic(emptyheart);
			add(p1heart4empty = new FlxSprite(22 + 3 * 40, 430));
			p1heart4empty.loadGraphic(emptyheart);
			add(p2heart1empty = new FlxSprite(1240 + 22 + 0 * 40, 430));
			p2heart1empty.loadGraphic(emptyheart);
			add(p2heart2empty = new FlxSprite(1240 + 22 + 1 * 40, 430));
			p2heart2empty.loadGraphic(emptyheart);
			add(p2heart3empty = new FlxSprite(1240 + 22 + 2 * 40, 430));
			p2heart3empty.loadGraphic(emptyheart);
			add(p2heart4empty = new FlxSprite(1240 + 22 + 3 * 40, 430));
			p2heart4empty.loadGraphic(emptyheart);
			
			add(p1heart1 = new FlxSprite(22 + 0 * 40, 430));
			p1heart1.loadGraphic(fullheart);
			add(p1heart2 = new FlxSprite(22 + 1 * 40, 430));
			p1heart2.loadGraphic(fullheart);
			add(p1heart3 = new FlxSprite(22 + 2 * 40, 430));
			p1heart3.loadGraphic(fullheart);
			add(p1heart4 = new FlxSprite(22 + 3 * 40, 430));
			p1heart4.loadGraphic(fullheart);
			add(p2heart1 = new FlxSprite(1240 + 22 + 0 * 40, 430));
			p2heart1.loadGraphic(fullheart);
			add(p2heart2 = new FlxSprite(1240 + 22 + 1 * 40, 430));
			p2heart2.loadGraphic(fullheart);
			add(p2heart3 = new FlxSprite(1240 + 22 + 2 * 40, 430));
			p2heart3.loadGraphic(fullheart);
			add(p2heart4 = new FlxSprite(1240 + 22 + 3 * 40, 430));
			p2heart4.loadGraphic(fullheart);
			
			this.player0 = new Player(0, player0title, player0name);
			this.player1 = new Player(1, player1title, player1name);
			
			this.level0 = new Level(this.player0, new FlxPoint(209, 50), this.operation_table0, this);
			this.level1 = new Level(this.player1, new FlxPoint(739, 50), this.operation_table1, this);
			
			player0.level = level0;
			player1.level = level1;
			
			this.levelLayer.add(this.level0);
			this.levelLayer.add(this.level1);
			
			this.levelLayer.add(this.operation_table0);
			this.levelLayer.add(this.operation_table1);
			
			// Patients
//			flock_group = new FlxGroup;
//			add(flock_group);
//			
//			flock = new Flock(flock_group, player0);
//			
//			
//			
//			for (var i : int = 0; i < 10; i++) {
//				var patient1 : Patient;
//				patient1 = new Patient(220 + Math.random() * (480 - 220), 60 + Math.random() * (800 - 60));
//				flock.add_patient(patient1);
//			}
			
			// HUD: Player

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
			
			getready = new FlxText(0, 60, 1440, "GET READY");
			getready.setFormat("Subtext", 80, 0xffffff, "center");
			add(getready);
			player1controlsprite = new FlxSprite(350, 200);
			player1controlsprite.loadGraphic(player1controls);
			add(player1controlsprite);
			player2controlsprite = new FlxSprite(800, 200);
			player2controlsprite.loadGraphic(player2controls);
			add(player2controlsprite);
			
			this.state = STATE_PLAYING;
		}
		
		private var first : Boolean = true;
		override public function update() : void {
			if (first) {
				first = false;
				FlxG.playMusic(loop);
			}
			
			super.update();
			
			if (getreadycountdown == 300) {
				FlxG.play(getreadysound);
			} if (getreadycountdown > 1) {
				getreadycountdown--;
			} else if (getreadycountdown == 1) {
				getreadycountdown = 0;
				FlxG.play(buildsound);
				remove(player1controlsprite);
				remove(player2controlsprite);
				remove(getready);
			}
			
			for each (var sprite0 : FlxSprite in p0EffectSlots) {
				if (sprite0 != null)
					this.levelLayer.remove(sprite0);
			}
			
			for each (var ptext0 : FlxText in p0TimerSlots) {
				if (ptext0 != null)
					this.levelLayer.remove(ptext0);
			}
			
			for each (var sprite1 : FlxSprite in p1EffectSlots) {
				if (sprite1 != null)
					this.levelLayer.remove(sprite1);
			}
			
			for each (var ptext1 : FlxText in p1TimerSlots) {
				if (ptext1 != null)
					this.levelLayer.remove(ptext1);
			}
			
			
			if (player0 != null) {
				var p0EffectsCount : uint = 0;
				for each (var effect0 : Pickup in player0.effects) {
					if (effect0 == null)
						continue; 
				
					if (effect0.state == Pickup.STATE_EFFECTING && effect0.timerInSeconds() > 0) {
						
						this.levelLayer.add(p0EffectSlots[p0EffectsCount] = new FlxSprite(22, 480 + p0EffectsCount * 52));
						p0EffectSlots[p0EffectsCount].loadGraphic(effect0.sprite);
					
						var text0 : FlxText = new FlxText(42, 485 + p0EffectsCount * 52, 200, effect0.timerInSeconds() + "S");
						text0.setFormat("Subtext", 32, 0xFFFFFF, "center");
						p0TimerSlots[p0EffectsCount] = text0;
						this.levelLayer.add(text0);
					
						p0EffectsCount++;
					}
				}
			}
			
			if (player1 != null) {
				var p1EffectsCount : uint = 0;
				for each (var effect1 : Pickup in player1.effects) {
					
					if (effect1 == null)
						continue; 
				
					if (effect1.state == Pickup.STATE_EFFECTING && effect1.timerInSeconds() > 0) {
						
						this.levelLayer.add(p1EffectSlots[p1EffectsCount] = new FlxSprite(1250, 480 + p1EffectsCount * 52));
						p1EffectSlots[p1EffectsCount].loadGraphic(effect1.sprite);
					
						var text1 : FlxText = new FlxText(1270, 485 + p1EffectsCount * 52, 200, effect1.timerInSeconds() + "S");
						text1.setFormat("Subtext", 32, 0xFFFFFF, "center");
						p1TimerSlots[p1EffectsCount] = text1;
						this.levelLayer.add(text1);
					
						p1EffectsCount++;
					}
				}
			}
			
//			flock.update();

			if (wincountdown1 != -1) {
				wincountdown1--;
				if (wincountdown1 == 0) FlxG.play(doc1win); 
			}
			
			if (wincountdown2 != -1) {
				wincountdown2--;
				if (wincountdown2 == 0) FlxG.play(doc2win); 
			}
			
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

			/*if (FlxG.keys.justPressed("Y"))
			{
				//this.level0.switchToZombies();
				this.swapPlayers();
			}*/
			
		}
		
		public function gameOver(winner : Player) : void {
			this.state = STATE_GAMEOVER;
			
			if (winner.playernumber == 0) {
				wincountdown1 = 100;
			} else {
				wincountdown2 = 100;
			}
			
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
		
		public function swapPlayers() : void {
			this.player0.swapWithPlayer(this.player1);			
		}
	}
}
