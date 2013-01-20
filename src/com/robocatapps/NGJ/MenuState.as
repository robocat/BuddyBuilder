package com.robocatapps.NGJ {
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
		}
		
		override public function update():void {
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new GameState());
			}
 
		}
 
 
		public function MenuState() {
			super();
 
		}
	}
}
