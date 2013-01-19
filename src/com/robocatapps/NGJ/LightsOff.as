package com.robocatapps.NGJ {
	import mx.core.IFlexAsset;
	import flashx.textLayout.conversion.FormatDescriptor;
	import org.flixel.FlxGroup;
	import org.flixel.*;

	/**
	 * @author neoneye
	 */
	public class LightsOff extends FlxGroup {
		[Embed(source="lights_off_gradient.png")] private var lights_off_gradient_sprite : Class;

		
		public static const TEXTURESIZE : uint = 512;
		public static const TILESIZE : uint = 32;
		public static const TILECOUNT : uint = TEXTURESIZE / TILESIZE;
		
		private var gradient_sprites : Array = null;
		private var clip_bounds : FlxRect = null;

		private var black_sprites : Array = null;

		public function LightsOff(clip_bounds : FlxRect) {
			super();
			
			this.clip_bounds = clip_bounds;
			
			var center : FlxPoint = new FlxPoint(TEXTURESIZE / 2, TEXTURESIZE / 2);

			this.gradient_sprites = new Array();
			for(var y:uint = 0; y<TILECOUNT; y++) {
				for(var x:uint = 0; x<TILECOUNT; x++) {
					var sprite : FlxSprite = new FlxSprite(0, 0);
					sprite.loadGraphic(lights_off_gradient_sprite, false, false, TILESIZE, TILESIZE);
					sprite.frame = y * TILECOUNT + x;
					sprite.offset = new FlxPoint(center.x + -x * TILESIZE, center.y + -y * TILESIZE);
					add(sprite);
					this.gradient_sprites.push(sprite);
				}
			}
			
			this.black_sprites = new Array();
			var count : uint = (clip_bounds.width / TILESIZE + 2) * (clip_bounds.height / TILESIZE + 2);
			for(var i:uint = 0; i<count; i++) {
				var black_sprite : FlxSprite = new FlxSprite(0, 0);
				black_sprite.makeGraphic(TILESIZE, TILESIZE);
				//black_sprite.color = 0xff0000;
				black_sprite.color = 0;
				black_sprite.visible = false;
				add(black_sprite);
				this.black_sprites.push(black_sprite);
			}
		}

		public function set_center(center : FlxPoint) : void {
			this.set_gradient_center(center);
			this.set_black_center(center);
		}
		
		public function set_gradient_center(center : FlxPoint) : void {
			for each (var sprite : FlxSprite in this.gradient_sprites) {
				sprite.x = center.x;
				sprite.y = center.y;
				var x : int = sprite.x - sprite.offset.x;
				var y : int = sprite.y - sprite.offset.y;
				var r : FlxRect = new FlxRect(x, y, TILESIZE, TILESIZE);
				var overlap : Boolean = r.overlaps(this.clip_bounds);
				sprite.visible = overlap;
			}
		}

		public function set_black_center(center : FlxPoint) : void {
			var offset_x : int = (center.x - 48 + TILESIZE*100) % TILESIZE;
			var offset_y : int = (center.y - 48 + TILESIZE*100) % TILESIZE;
			offset_x -= TILESIZE;
			offset_y -= TILESIZE;
			offset_x += this.clip_bounds.x;
			offset_y += this.clip_bounds.y;
			
			var tile_x : int = 0; 
			var tile_y : int = 0; 
			
			
			var gradient_rect : FlxRect = new FlxRect(center.x - TEXTURESIZE / 2, center.y - TEXTURESIZE / 2, TEXTURESIZE-1, TEXTURESIZE-1);
			
			for each (var sprite : FlxSprite in this.black_sprites) {
				sprite.x = offset_x + tile_x * TILESIZE;
				sprite.y = offset_y + tile_y * TILESIZE;
				var x : int = sprite.x;
				var y : int = sprite.y;
				var r : FlxRect = new FlxRect(x, y, TILESIZE-1, TILESIZE-1);
				var gradient_overlap : Boolean = r.overlaps(gradient_rect);
				var overlap : Boolean = r.overlaps(this.clip_bounds);
				if(gradient_overlap) {
					sprite.visible = false;
				} else {
					sprite.visible = overlap;
				}
				if(tile_x > 3 && !overlap) {
					tile_x = 0;
					tile_y++;
				} else {
					tile_x++;
				}
			}
		}

	}
}
