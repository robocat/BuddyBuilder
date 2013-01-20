package com.robocatapps.NGJ {
	import org.flixel.*;
	
	public class HUDSprite extends FlxSprite {
		private var count : uint;
		private var group : FlxGroup;
		private var txt : FlxText;
		private var area : uint;
		
		public function HUDSprite(img : Class, area : uint, name : String, group : FlxGroup) : void {
			loadGraphic(img);
			x = 450 - width / 2 + (area == 1? 540: 0);
			y = 200;
			scale = new FlxPoint(2, 2);
			this.group = group;
			this.area = area;
			
			txt = new FlxText(area == 0? 200: 740, y + height + 80, 500, name);
			txt.setFormat("Heading", 75, 0xffffffff, "center", 0x000000);
			
			group.add(this);
			group.add(txt);
		}
		
		override public function update() : void {
			count++;
			
			if (count == 10) { alpha = 0; txt.alpha = 0; }
			if (count == 20) { alpha = 1; txt.alpha = 1; }
			if (count == 30) { alpha = 0; txt.alpha = 0; }
			if (count == 40) { alpha = 1; txt.alpha = 1; }
			if (count == 50) { alpha = 0; txt.alpha = 0; }
			if (count == 60) { alpha = 1; txt.alpha = 1; }
			
			if (count > 150) {
				var prog : Number = (Number)(count - 150.0) / 50.0;
				txt.alpha = 1 - prog;
				scale = new FlxPoint(2 - prog, 2 - prog);
				x -= prog * 10 * (area == 0? 1: -1);
			}
			
			if (count > 210) {
				group.remove(txt);
				group.remove(this);
			}
		}
	}
}
