package com.robocatapps.NGJ {
	import flash.geom.Rectangle;
	import flash.display.StageDisplayState;
	import org.flixel.*;
	
	/*
	 * @author ksma
	 */
	public class MenuState extends FlxState {
		[Embed(source="title_bg.png")] private var menubg : Class;
		[Embed(source="title_loop.mp3")] private var loop : Class;
		
		override public function create():void {
			var bg : FlxSprite = new FlxSprite(0, 0);
			bg.loadGraphic(menubg);
			add(bg);
			
			var instructions:FlxText = new FlxText(595, 620, 1000, "Press Space To Play");
			instructions.setFormat (null, 40, 0x42dfe0, "left");
			add(instructions);
			
			FlxG.playMusic(loop);
			
			var fullscreenButton : FlxButton = new FlxButton(10, 10, "Fullscreen", toggle_fullscreen);
			add(fullscreenButton);
		}
		
		private function toggle_fullscreen() : void {
			if (FlxG.stage.displayState == StageDisplayState.NORMAL) {
				FlxG.stage.fullScreenSourceRect = new Rectangle(0, 0, 1440, 900);
				FlxG.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			else FlxG.stage.displayState = StageDisplayState.NORMAL;
		}
		
		override public function update():void {
			super.update(); // calls update on everything you added to the game loop
 			
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.music.stop();
				FlxG.switchState(new GameState());
			}
 
		}
 
 
		public function MenuState() {
			super();
 
		}
	}
}
