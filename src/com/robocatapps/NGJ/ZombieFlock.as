package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;
	/**
	 * @author willi
	 */
	public class ZombieFlock {
		
		public var zombies:Array = [];
		
		public var player:Player;
		
		
		private var group:FlxGroup;
		
		private var player_seek_strength:Number = 0.1;
		
		private var zombie_size:Number = 100.0;
		
		private var zombie_minimum_distance:Number = 30.0;
		
		private var previous_velocity : FlxPoint;
		
		
		public function ZombieFlock(group:FlxGroup, player:Player):void {
            this.player = player;
            this.group = group;
			
			previous_velocity = new FlxPoint();
        }
		
		
		public function add_zombie(zombie:Zombie):void {
            // Create a clone of the object & destroy the original.
            var new_zombie:Zombie = new Zombie(zombie.level, zombie.x, zombie.y);
            zombies.push(new_zombie);
            group.add(new_zombie);          
            zombie.kill();
        }
        
        public function update():void {
            cohere();
            separate();
            align();

//            if (player.velocity.x || player.velocity.y) {
//                seek(new FlxPoint(player.x, player.y), player_seek_strength);
//            }

//			flee(new FlxPoint(player.x, player.y), -4);
        }
		
		
		private function movement(zombie : Zombie, vel_x : Number, vel_y : Number):void {
			
			if (Math.abs(vel_x) > Zombie.STAND_VELOCITY && Math.abs(vel_y) > Zombie.STAND_VELOCITY
				&& Math.abs(vel_x) < Zombie.RUN_VELOCITY && Math.abs(vel_y) < Zombie.RUN_VELOCITY)
			{
				 zombie.velocity.x = (vel_x > 0.0) ? Zombie.WALK_VELOCITY : -Zombie.WALK_VELOCITY;
				 zombie.velocity.y = (vel_y > 0.0) ? Zombie.WALK_VELOCITY : -Zombie.WALK_VELOCITY;
			}
			else if (Math.abs(vel_x) > Zombie.RUN_VELOCITY && Math.abs(vel_y) > Zombie.RUN_VELOCITY)
			{
				 zombie.velocity.x = (vel_x > 0.0) ? Zombie.RUN_VELOCITY : -Zombie.RUN_VELOCITY;
				 zombie.velocity.y = (vel_y > 0.0) ? Zombie.RUN_VELOCITY : -Zombie.RUN_VELOCITY;
			}
			else {
				 zombie.velocity.x = Zombie.STAND_VELOCITY;
				 zombie.velocity.y = Zombie.STAND_VELOCITY;
			}
		}
		

        public function cohere():void {
//            // A special case for one
//            if (zombies.length == 1) {
//                seek(new FlxPoint(player.x, player.y), player_seek_strength, 32);
//                return;
//            }
//            
//            var total_position:FlxPoint = new FlxPoint(0,0);
//            var average_position:FlxPoint = new FlxPoint(0,0);
//
//            for (var j:int = 0; j < zombies.length; j++) {
//                total_position.x += zombies[j].x;
//                total_position.y += zombies[j].y;
//            }
//            
//            for (var i:int = 0; i < zombies.length; i++) {
//                var zombie:Zombie = zombies[i];
//                
//                // Re-set the average position object for this zombie
//                average_position.x = (total_position.x - zombie.x) / (zombies.length - 1);
//                average_position.y = (total_position.y - zombie.y) / (zombies.length - 1);
//
//                zombie.velocity.x += ((average_position.x - zombie.x) / 20) * FlxG.elapsed;
//                zombie.velocity.y += ((average_position.y - zombie.y) / 20) * FlxG.elapsed;
//            }
			
			for each (var zombie : Zombie in zombies) {
				
//				if (zombie.animationState == Zombie.RUN) {
//					continue;
//				}
				
				var distance:Number = Math.abs(
                            Math.sqrt( Math.pow(zombie.destination.x - zombie.x, 2) + Math.pow(zombie.destination.y - zombie.y, 2) )
                        )
						
				if (distance < 1) {
					zombie.new_distination();
				}
//				else if (zombie.velocity.x < 1 && zombie.velocity.x < 1) {
//					zombie.new_distination();
//				}
//				
//				zombie.velocity.x += ((zombie.destination.x - zombie.x) / 20) * FlxG.elapsed;
//				zombie.velocity.y += ((zombie.destination.y - zombie.y) / 20) * FlxG.elapsed;

//				FlxVelocity.moveTowardsPoint(zombie, zombie.destination);
				
				
				var vel_x : Number = zombie.velocity.x + ((zombie.destination.x - zombie.x) / 20) * FlxG.elapsed;
				var vel_y : Number = zombie.velocity.y + ((zombie.destination.y - zombie.y) / 20) * FlxG.elapsed;
				
				if (previous_velocity.x != vel_x && previous_velocity.y != vel_y)
				{
					movement(zombie, vel_x, vel_y);
					
					previous_velocity.x = zombie.velocity.x;
					previous_velocity.y = zombie.velocity.y;			
				}
			}
			
        }
        
        public function separate():void {
            var min_distance:uint = zombie_size;
            
			for each (var zombie : Zombie in zombies) {

                var x_adjustment:int = 0;
                var y_adjustment:int = 0;
                
				for each (var other_zombie : Zombie in zombies) {

                    if (other_zombie != zombie) {
                        var distance:Number = Math.abs(
                            Math.sqrt( Math.pow(other_zombie.x - zombie.x, 2) + Math.pow(other_zombie.y - zombie.y, 2) )
                        )

                        if (distance < min_distance) {
                            x_adjustment -= (other_zombie.x - zombie.x);
                            y_adjustment -= (other_zombie.y - zombie.y);
                        }
                    }
                }

				var vel_x : Number = zombie.velocity.x + x_adjustment / 2;
				var vel_y : Number = zombie.velocity.y + y_adjustment / 2;

				if (previous_velocity.x != vel_x && previous_velocity.y != vel_y)
				{
					zombie.velocity.x = vel_x;
                	zombie.velocity.y = vel_y;
					
					previous_velocity.x = zombie.velocity.x;
					previous_velocity.y = zombie.velocity.y;					
				}
                
				
//				var vel_x : Number = zombie.velocity.x + x_adjustment / 2;
//				var vel_y : Number = zombie.velocity.y + y_adjustment / 2;
//				
//				movement(zombie, vel_x, vel_y);
            }
        }

        public function align():void {
            for each (var zombie : Zombie in zombies) {

                var x_adjustment:int = 0;
                var y_adjustment:int = 0;                
                
                for each (var other_zombie : Zombie in zombies) {
                    if (other_zombie != zombie) {
                        x_adjustment += zombie.velocity.x;
                        y_adjustment += zombie.velocity.y;
                    }
                }

                x_adjustment = x_adjustment / (zombies.length - 1);
                y_adjustment = y_adjustment / (zombies.length - 1);

				
				var vel_x : Number = zombie.velocity.x + (x_adjustment - zombie.velocity.x) / 8;
				var vel_y : Number = zombie.velocity.y + (y_adjustment - zombie.velocity.y) / 8;

				if (previous_velocity.x != vel_x && previous_velocity.y != vel_y)
				{
					zombie.velocity.x = vel_x;
                	zombie.velocity.y = vel_y;
					
					previous_velocity.x = zombie.velocity.x;
					previous_velocity.y = zombie.velocity.y;
				}
				
//				var vel_x : Number = zombie.velocity.x + (x_adjustment - zombie.velocity.x) / 8;
//				var vel_y : Number = zombie.velocity.y + (y_adjustment - zombie.velocity.y) / 8;
//				
//				movement(zombie, vel_x, vel_y);
            }
        }

        public function seek(target:FlxPoint, amount:Number, max_distance:uint = 10):void {
            for each (var zombie : Zombie in zombies) {
                
                var distance:Number = Math.abs(
                    Math.sqrt( Math.pow(target.x - zombie.x, 2) + Math.pow(target.y - zombie.y, 2) )
                );

                if (distance > max_distance) {
                    zombie.velocity.x += ((target.x - zombie.x) * amount) * FlxG.elapsed;
                    zombie.velocity.y += ((target.y - zombie.y) * amount) * FlxG.elapsed;
                }
            }
		}
		
		
		public function flee(target:FlxPoint, amount:Number = -2, max_distance:uint = 100):void {
            for each (var zombie : Zombie in zombies) {
                
                var distance:Number = Math.abs(
                    Math.sqrt( Math.pow(target.x - zombie.x, 2) + Math.pow(target.y - zombie.y, 2) )
                );
				
//				trace("distance");
//				trace(distance);

                if (distance < max_distance) {
                    zombie.velocity.x *= amount;
                    zombie.velocity.y *= amount;
                }
            }
		}
	}
}
