package com.robocatapps.NGJ {
	import org.flixel.FlxSprite;

	/**
	 * @author neoneye
	 */
	public class OperationTable extends FlxSprite {
		//[Embed(source="operation_table.png")] private var operation_table_sprite : Class;

		private var cont : uint;
		private var scene : GameState;
		
		public function OperationTable(controls:uint, x:uint, y:uint, scene:GameState) : void {
			cont = controls;
			//loadGraphic(operation_table_sprite, false, false, 128, 128, false);
			this.x = x;
			this.y = y;
			this.scene = scene;
		}

	}
}
