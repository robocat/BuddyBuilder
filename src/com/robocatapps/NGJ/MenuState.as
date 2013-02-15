package com.robocatapps.NGJ {
	import mx.core.IFlexAsset;
	import flash.geom.Rectangle;
	import flash.display.StageDisplayState;
	import org.flixel.*;
	
	/*
	 * @author ksma
	 */
	public class MenuState extends FlxState {
		[Embed(source="title_bg.png")] private var menubg : Class;
		[Embed(source="title_loop.mp3")] private var loop : Class;
		
		private var tick : uint = 0;
		private var overlay : FlxSprite;
		
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
			
			overlay = new FlxSprite(0, 0);
			overlay.makeGraphic(FlxG.width, FlxG.height);
			overlay.color = 0x000000;
			overlay.alpha = .75;
			add(overlay);
		}
		
		private function toggle_fullscreen() : void {
			if (FlxG.stage.displayState == StageDisplayState.NORMAL) {
				FlxG.stage.fullScreenSourceRect = new Rectangle(0, 0, 980, 613);
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
 			
			tick++;
			
			if (tick == 10) overlay.alpha = 0;
			if (tick == 11) overlay.alpha = .5;
			if (tick == 20) overlay.alpha = 0;
			if (tick == 21) overlay.alpha = .5;
			if (tick == 40) overlay.alpha = 0;
		}
 
 
		public function MenuState() {
			super();
 
		}
	}
}
