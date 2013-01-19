package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.FlxGradient;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxG;
	import flash.display.Graphics;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.*;
	/**
	 * @author ksma
	 */
	public class Level extends FlxGroup {
		// Sprites
		[Embed(source="light_mask.png")] private var lightSprite : Class;
		[Embed(source="dark.png")] private var darkSprite : Class;
		[Embed(source="light0.mp3")] private var light0Sound:Class;
		
		public static const MAXPATIENTS :uint = 10; 
		
		// Instance vars
		public var player:Player;
		public var pickups : Array;
		public var obstacles : Array;
		public var corpses : Array;
		
		public var gameState : GameState;

		public var operation_table : OperationTable;
		
		// Layers
		public var backgroundLayer : FlxGroup;
		public var enemyLayer : FlxGroup;
		public var obstacleLayer : FlxGroup;
		public var bloodLayer : FlxGroup;
		public var itemLayer : FlxGroup;
		public var playerLayer : FlxGroup;
		public var lightLayer : FlxGroup;
		
		public var flock:Flock;

		
		// Layout
		public var origin : FlxPoint;
		public var width : uint = 510;
		public var height: uint = 820;
		
		// Effects
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		private var dark : FlxSprite;
		private var darkCounter : uint = 0;
		private var darkMaxCounter : uint = 400;
		private var darkOn : Boolean = false;
		
		public function Level(player: Player, origin : FlxPoint, operation_table : OperationTable, state : GameState):void {
			this.pickups = new Array();
			this.obstacles = new Array();
			
			this.origin = origin;
			this.gameState = state;
			this.operation_table = operation_table;
			
			// Add the floor first since it needs 
			// to beneath the player
			//this.addFloor();
			
			
			backgroundLayer = new FlxGroup();
			enemyLayer  = new FlxGroup();
			obstacleLayer = new FlxGroup();
			bloodLayer = new FlxGroup();
			itemLayer  = new FlxGroup();
			lightLayer  = new FlxGroup();
			playerLayer  = new FlxGroup();
			
			
			add(backgroundLayer);
			add(enemyLayer);
			add(itemLayer);
			add(obstacleLayer);
			add(bloodLayer);
			add(lightLayer);
			add(playerLayer);
			
			// Add obstacles to the level
			this.addObstacles();
			
			
			// Add the light sprite for flickering
			this.light = new FlxSprite(this.origin.x, this.origin.y, lightSprite);
			this.light.alpha = 0;
			this.lightLayer.add(this.light);
			
			// Add sprite for turning off the lights
			
			
			this.dark = new FlxSprite(this.origin.x, this.origin.y, darkSprite);
			this.dark.alpha = 0;
			this.lightLayer.add(this.dark);
 
			
			// Add the player for the level
			this.player = player;
			this.playerLayer.add(this.player);
			
			flock = new Flock(enemyLayer, player);
		}
		
		private function addObstacles():void {
			this.obstacles.push(new Obstacle(this.origin.x + this.width/2 - 128/2, this.origin.y + height/2 - 64/2, Obstacle.SOFA));
			
			for each (var obstacle : Obstacle in this.obstacles) {
				this.obstacleLayer.add(obstacle);
			}
		}
		
		public function turnOffLights():void {
			this.dark.alpha = 1;
			this.darkCounter = 0;
			this.darkOn = true;
			
			FlxG.play(light0Sound);
		}
		
		public function turnOnLights():void {
			this.dark.alpha = 0;
			this.darkCounter = 0;
			this.darkOn = false;
		}
		
		override public function update():void {
			super.update();
			
			flock.update();
			
			if (this.gameState.state != GameState.STATE_PLAYING)
				return;
			
			if (this.darkOn) {
				this.darkCounter++;
				
				if (this.darkCounter > this.darkMaxCounter) {
					this.turnOnLights();
				}
			}
			
			var count : uint = 0;
			for each (var patient : Patient in flock.patients) {
				if (patient != null)
					count++;
			}
			
			trace('patients ' + count);
			
			if (Math.random() < 0.01 && count <= MAXPATIENTS) {
				addPatient();
			}
			
			for each (var pickup : Pickup in pickups) {
				if (pickup.timedOut) {
					this.itemLayer.remove(pickup);
					delete this.pickups[this.pickups.indexOf(pickup)];
				}
			}
			
			for each (var corpse : Corpse in corpses) {
				if (corpse.gone) {
					delete corpses[corpses.indexOf(corpse)];
				}
			}
			
			//if ((light_counter++) > Math.random() * 100) {
			//	light_counter = 0;
			//	light.alpha = Math.random() * 0.25 + 0.25;
			//}
		}
		
		public function getOpponent() : Player {
			return gameState.getOpponnent(this.player);
		}
		
		public function addPatient() : void {
			var patient : Patient;
			patient = new Patient(this, origin.x + 10 + Math.random() * 480, origin.y + 10 + Math.random() * 800);
			flock.add_patient(patient);
		}
		
		public function addDrop() : void {
			var x : uint = this.origin.x + Math.random() * (500 - 40);
			var y : uint = this.origin.y + Math.random() * (820 - 40);
			
			var length : uint = Pickup.DROP_TYPES.length;
			var dropType : uint = Math.floor(Math.random() * length + 1);
			if (dropType > length)
				dropType = length;
				
			var item : String = Pickup.DROP_TYPES[dropType];
			
			if (item == null)
				return;
				
			var drop : Pickup = new Pickup(x, y, item);
			
			var collision : Boolean = false;
			for each (var obstacle : Obstacle in this.obstacles) {
				if (FlxCollision.pixelPerfectCheck(drop, obstacle)) {
					collision = true;
				}
			}
			
			if (!collision) {
				this.itemLayer.add(drop);
				pickups.push(drop);
			}
		}
	}
}
