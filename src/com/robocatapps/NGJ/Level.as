package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.FlxGradient;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxG;
	import flash.display.Graphics;
	import org.flixel.FlxPoint;
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

		public var operation_table : OperationTable;
		
		// Layers
		public var backgroundLayer : FlxGroup;
		public var enemyLayer : FlxGroup;
		public var itemLayer : FlxGroup;
		public var playerLayer : FlxGroup;
		public var lightLayer : FlxGroup;

		
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
			this.npcs = new Array();
			
			this.origin = origin;
			this.state = state;
			this.operation_table = operation_table;
			
			// Add the floor first since it needs 
			// to beneath the player
			//this.addFloor();
			
			
			backgroundLayer = new FlxGroup();
			enemyLayer  = new FlxGroup();
			itemLayer  = new FlxGroup();
			lightLayer  = new FlxGroup();
			playerLayer  = new FlxGroup();
			
			
			add(backgroundLayer);
			add(enemyLayer);
			add(itemLayer);
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
		}
		
		private function addFloor():void {
			var floor : FlxSprite = new FlxSprite(this.origin.x, this.origin.y, floorSprite);
			floor.loadGraphic(floorSprite);
			this.backgroundLayer.add(floor);
		}
		
		private function addObstacles():void {
			this.obstacles.push(new Obstacle(this.origin.x + 40, this.origin.y + 40, "bed"));
			
			for each (var obstacle : Obstacle in this.obstacles) {
				this.itemLayer.add(obstacle);
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
				var x : uint = this.origin.x + Math.random() * (500 - 40);
				var y : uint = this.origin.y + Math.random() * (820 - 40);
				
				var hitlerkage : Pickup = new Pickup(x, y, "hitlerkage");
				
				var collision : Boolean = false;
				for each (var obstacle : Obstacle in this.obstacles) {
					if (FlxCollision.pixelPerfectCheck(hitlerkage, obstacle)) {
						collision = true;
					}
				}
				
				if (!collision) {
					this.itemLayer.add(hitlerkage);
					pickups.push(hitlerkage);
				}
			}
			
			//if ((light_counter++) > Math.random() * 100) {
			//	light_counter = 0;
			//	light.alpha = Math.random() * 0.25 + 0.25;
			//}
		}
		
		public function getOpponent() : Player {
			return state.getOpponnent(this.player);
		}
	}
}
