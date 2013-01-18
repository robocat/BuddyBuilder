package com.robocatapps.NGJ {
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	
	/*
	 * @author ksma
	 */
	public class MenuState extends FlxState {
		override public function create():void
		{
			var title:FlxText = new FlxText(0, 16, FlxG.width, "Dr. Evil");
			title.setFormat(null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Play");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
		}
		
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new GameState());
			}
 
		} // end function update
 
 
		public function MenuState()
		{
			super();
 
		}  // end function MenuState
	}
}
