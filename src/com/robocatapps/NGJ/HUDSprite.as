package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class HUDSprite extends FlxSprite {
		private var count : uint;
		private var group : FlxGroup;
		private var txt : FlxText;
		private var area : uint;
		private var toOpearationTable : Boolean;
		
		public function HUDSprite(img : Class, area : uint, name : String, group : FlxGroup, toOperationTable : Boolean) : void {
			loadGraphic(img);
			x = 450 - width / 2 + (area == 1? 540: 0);
			y = 200;
			scale = new FlxPoint(2, 2);
			this.group = group;
			this.area = area;
			this.toOpearationTable = toOperationTable;
			
			txt = new FlxText(area == 0? 200: 740, y + height + 80, 500, name);
			txt.setFormat("Heading", 75, 0xffffffff, "center", 0x000000);
			
			group.add(this);
			group.add(txt);
		}
		
		override public function update() : void {
			count++;
			
			if (toOpearationTable) {
				if (count > 80) {
					var prog : Number = (Number)(count - 80.0) / 30.0;
					txt.alpha = 1 - prog;
					scale = new FlxPoint(2 - prog, 2 - prog);
					x -= prog * 18 * (area == 0? 1: -1);
				}
			} else {
				if (count >= 70) alpha = 0;
			}
			
			if (count > 70) {
				group.remove(txt);
				group.remove(this);
			}
		}
	}
}
