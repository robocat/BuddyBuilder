package com.robocatapps.NGJ {
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	import org.flixel.FlxState;

	import flash.display.Shape;

	/**
	 * @author annemettepoulsen
	 */
	public class GameOverState extends FlxState {
	
		public function GameOverState() {
			
		//	var circle :Shape = new Shape();
		//	circle.graphics.beginFill(0xFFFF00);
		//	circle.graphics.drawCircle(150, 150, 100);
			//add(circle);
				
			
			//var font :Font = new Font();
		//	var text :TextField = new TextField();
		//	text.text ="Game Fucking Over!";
		//	text.textColor = 0xFFFF00;
						
			var title:FlxText = new FlxText(0, 16, FlxG.width -500, "GAME OVER SUCKER");
			title.setFormat(null, 160, 0xFFF00FFF, "center");
			add(title);
						
		}
	}
}
