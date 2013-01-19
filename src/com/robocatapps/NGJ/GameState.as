package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class GameState extends FlxState {
		[Embed(source="tile.png")] private var tileSprite : Class;
		[Embed(source="bed.png")] private var bedSprite : Class;
		[Embed(source="light.png")] private var lightSprite : Class;
		[Embed(source="level_grid.png")] private var gridSprite : Class;
		
		private var player1 : Player;
		private var player2 : Player;
		
		public var pickups : Array;
		public var obstacles : Array;
		
		private var light : FlxSprite;
		private var light_counter : uint = 0;
		
		public function GameState() : void {
			var grid : FlxSprite = new FlxSprite(0, 0);
			grid.loadGraphic(gridSprite);
			add(grid);

			create_floor(0);
			create_floor(1);
			if(0){
				var width : uint = 500;
				for (var i : uint = 0; i < width / 64; i++) {
					for (var j : uint = 0; j < FlxG.height / 64; j++) {
						var tile : FlxSprite = new FlxSprite(i * 64, j * 64);
						tile.loadGraphic(tileSprite);
						add(tile);
						tile.x += 200;
					}
				}
			}
			
			pickups = new Array();
			obstacles = new Array();
			
			player1 = new Player(1, 100, 100, this);
			player2 = new Player(0, 600, 300, this);
			
			add(player1);
			add(player2);
			
			var ob1 : FlxSprite = new FlxSprite(64, 320, bedSprite);
			obstacles.push(ob1);
			add(ob1);
			
			light = new FlxSprite(0, 0, lightSprite);
			add(light);
		}
		
		public function create_floor(side : uint) : void {
			var tile_x : uint = (side == 0) ? 200 : 740; 
			var width : uint = 500;
			for (var i : uint = 0; i < width / 64; i++) {
				for (var j : uint = 0; j < FlxG.height / 64; j++) {
					var tile : FlxSprite = new FlxSprite(i * 64, j * 64);
					tile.loadGraphic(tileSprite);
					add(tile);
					tile.x += tile_x;
				}
			}
		}
		
		override public function update() : void {
			super.update();
			
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
			}
			
			if (Math.random() < 0.01) {
				var hitlerkage : Pickup = new Pickup(Math.random() * (FlxG.width - 100) + 50, Math.random() * (FlxG.height - 100) + 50, "hitlerkage");
				add(hitlerkage);
				pickups.push(hitlerkage);
			}
			
			if ((light_counter++) > Math.random() * 100) {
				light_counter = 0;
				light.alpha = Math.random() * 0.25 + 0.25;
			}
		}
	}
}
