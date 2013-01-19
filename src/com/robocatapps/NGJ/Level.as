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
		[Embed(source="dark.png")] private var darkSprite : Class;
		
		// Instance vars
		public var player:Player;
		public var pickups : Array;
		public var obstacles : Array;
		public var npcs : Array;
		
		private var state : GameState;

		private var operation_table : OperationTable;

		
		// Layout
		public var origin : FlxPoint;
		
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
			this.npcs = new Array();
			
			this.origin = origin;
			this.state = state;
			this.operation_table = operation_table;
			
			// Add the floor first since it needs 
			// to beneath the player
			this.addFloor();
			
			// Add obstacles to the level
			this.addObstacles();
			
			
			// Add the light sprite for flickering
			this.light = new FlxSprite(this.origin.x, this.origin.y, lightSprite);
			add(this.light);
			
			// Add sprite for turning off the lights
			this.dark = new FlxSprite(this.origin.x, this.origin.y, darkSprite);
			this.dark.alpha = 0;
			add(this.dark);
			
			// Add the player for the level
			this.player = player;

			add(this.player);
		}
		
		private function addFloor():void {
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
		
		public function turnOffLights():void {
			this.dark.alpha = 1;
			this.darkCounter = 0;
			this.darkOn = true;
		}
		
		public function turnOnLights():void {
			this.dark.alpha = 0;
			this.darkCounter = 0;
			this.darkOn = false;
		}
		
		override public function update():void {
			super.update();
			
			if (this.darkOn) {
				this.darkCounter++;
				
				if (this.darkCounter > this.darkMaxCounter) {
					this.turnOnLights();
				}
			}
			
			if (Math.random() < 0.001) {
				var hitlerkage : Pickup = new Pickup(this.origin.x + Math.random() * (500 - 40), this.origin.y + Math.random() * (820 - 40), "hitlerkage");
				add(hitlerkage);
				pickups.push(hitlerkage);
			}
			
			if ((light_counter++) > Math.random() * 100) {
				light_counter = 0;
				light.alpha = Math.random() * 0.25 + 0.25;
			}
		}
		
		public function getOpponent() : Player {
			return state.getOpponnent(this.player);
		}
	}
}
