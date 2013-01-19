package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class GameState extends FlxState {
		[Embed(source="bed.png")] private var bedSprite : Class;
		[Embed(source="light.png")] private var lightSprite : Class;
		[Embed(source="level_grid.png")] private var gridSprite : Class;
		
		private var player0 : Player;
		private var player1 : Player;
		
		private var level0 : Level;
		private var level1 : Level;
		
		private var patient1 : Patient;
		
		private var flock_group:FlxGroup;
		private var flock:Flock;
		
		private var operation_table0 : OperationTable;
		private var operation_table1 : OperationTable;
		
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		public function GameState() : void {
			var grid : FlxSprite = new FlxSprite(0, 0);
			grid.loadGraphic(gridSprite);
			add(grid);
			
			this.operation_table0 = new OperationTable(0, new FlxPoint(20, 106));
			this.operation_table1 = new OperationTable(1, new FlxPoint(1261, 106));
			this.operation_table0.add_to_body(OperationTable.TORSO);
			this.operation_table1.add_to_body(OperationTable.RIGHT_ARM | OperationTable.LEFT_LEG | OperationTable.HEAD);
			
			this.player0 = new Player(0);
			this.player1 = new Player(1);
			
			this.level0 = new Level(this.player0, new FlxPoint(209, 50), this.operation_table0, this);
			this.level1 = new Level(this.player1, new FlxPoint(739, 50), this.operation_table1, this);
			
			player0.level = level0;
			player1.level = level1;
			
			add(this.level0);
			add(this.level1);
			
			add(this.operation_table0);
			add(this.operation_table1);
			
			// Patients
//			flock_group = new FlxGroup;
//			add(flock_group);
//			
//			flock = new Flock(flock_group, player0);
//			
//			
//			
//			for (var i : int = 0; i < 20; i++) {
//				var patient1 : Patient;
//				patient1 = new Patient(Math.random()*700, Math.random()*800);
//				flock.add_patient(patient1);
//			}
			
			// HUD: Player

			{
				var txt0 : FlxText = new FlxText(20,39,180, "DOCTOR 1");
				txt0.setFormat("Heading", 30, 0xffffffff, "left");
				add(txt0);
			}
			{
				var txt1 : FlxText = new FlxText(1261,39,180, "DOCTOR 2");
				txt1.setFormat("Heading", 30, 0xffffffff, "left");
				add(txt1);
			}
			{
				var sub0 : FlxText = new FlxText(18,79,181, "Wozniacki");
				sub0.setFormat("Subtext", 16, 0x3bd9d8ff, "left");
				add(sub0);
			}
			{
				var sub1 : FlxText = new FlxText(1259,79,181, "Tsurenko");
				sub1.setFormat("Subtext", 16, 0x1fc89aff, "left");
				add(sub1);
			}
		}
		
		override public function update() : void {
			super.update();
			
//			flock.update();
			
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
		
		public function getOpponnent(player : Player):Player {
			if (player == this.player0){
				return this.player1;
			} else {
				return this.player0;
			}
		}
	}
}
