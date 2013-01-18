package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class Player extends FlxSprite {
		private var cont : uint;
		
		[Embed(source="player.png")] private var sprite : Class;
		
		public function Player(controls:uint, x:uint, y:uint) : void {
			cont = controls;
			loadGraphic(sprite, false, false, 128, 128, false);
			this.x = x;
			this.y = y;
		}
		
		override public function update() : void {
			if ((cont == 0 && FlxG.keys.pressed("LEFT")) || (cont == 1 && FlxG.keys.pressed("A"))) {
				x -= 5;
				frame = 1;
			} else if ((cont == 0 && FlxG.keys.pressed("RIGHT")) || (cont == 1 && FlxG.keys.pressed("D"))) {
				x += 5;
				frame = 0;
			}
			
			if ((cont == 0 && FlxG.keys.pressed("UP")) || (cont == 1 && FlxG.keys.pressed("W"))) {
				y -= 5;
			} else if ((cont == 0 && FlxG.keys.pressed("DOWN")) || (cont == 1 && FlxG.keys.pressed("S"))) {
				y += 5;
			}
			
			x = (x < 0? 0: x > FlxG.width - width? FlxG.width - width: x);
			y = (y < 0? 0: y > FlxG.height - height? FlxG.height - height: y);
		}
	}
}
