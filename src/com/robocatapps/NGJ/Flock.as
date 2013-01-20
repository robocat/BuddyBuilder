package com.robocatapps.NGJ {
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;
	/**
	 * @author willi
	 */
	public class Flock {
		
		public var patients:Array = [];
		
		public var player:Player;
		
		
		private var group:FlxGroup;
		
		private var player_seek_strength:Number = 0.1;
		
		private var patient_size:Number = 100.0;
		
		private var patient_minimum_distance:Number = 30.0;
		
		private var previous_velocity : FlxPoint;
		
		
		public function Flock(group:FlxGroup, player:Player):void {
            this.player = player;
            this.group = group;
			
			previous_velocity = new FlxPoint();
        }
		
		
		public function add_patient(patient:Patient):void {
            // Create a clone of the object & destroy the original.
            var new_patient:Patient = new Patient(patient.level, patient.x, patient.y);
            patients.push(new_patient);
            group.add(new_patient);          
            patient.kill();
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
		
		
		private function movement(patient : Patient, vel_x : Number, vel_y : Number):void {
			
			if (Math.abs(vel_x) > Patient.STAND_VELOCITY && Math.abs(vel_y) > Patient.STAND_VELOCITY
				&& Math.abs(vel_x) < Patient.RUN_VELOCITY && Math.abs(vel_y) < Patient.RUN_VELOCITY)
			{
				 patient.velocity.x = (vel_x > 0.0) ? Patient.WALK_VELOCITY : -Patient.WALK_VELOCITY;
				 patient.velocity.y = (vel_y > 0.0) ? Patient.WALK_VELOCITY : -Patient.WALK_VELOCITY;
			}
			else if (Math.abs(vel_x) > Patient.RUN_VELOCITY && Math.abs(vel_y) > Patient.RUN_VELOCITY)
			{
				 patient.velocity.x = (vel_x > 0.0) ? Patient.RUN_VELOCITY : -Patient.RUN_VELOCITY;
				 patient.velocity.y = (vel_y > 0.0) ? Patient.RUN_VELOCITY : -Patient.RUN_VELOCITY;
			}
			else {
				 patient.velocity.x = Patient.STAND_VELOCITY;
				 patient.velocity.y = Patient.STAND_VELOCITY;
			}
		}
		

        public function cohere():void {
//            // A special case for one
//            if (patients.length == 1) {
//                seek(new FlxPoint(player.x, player.y), player_seek_strength, 32);
//                return;
//            }
//            
//            var total_position:FlxPoint = new FlxPoint(0,0);
//            var average_position:FlxPoint = new FlxPoint(0,0);
//
//            for (var j:int = 0; j < patients.length; j++) {
//                total_position.x += patients[j].x;
//                total_position.y += patients[j].y;
//            }
//            
//            for (var i:int = 0; i < patients.length; i++) {
//                var patient:Patient = patients[i];
//                
//                // Re-set the average position object for this patient
//                average_position.x = (total_position.x - patient.x) / (patients.length - 1);
//                average_position.y = (total_position.y - patient.y) / (patients.length - 1);
//
//                patient.velocity.x += ((average_position.x - patient.x) / 20) * FlxG.elapsed;
//                patient.velocity.y += ((average_position.y - patient.y) / 20) * FlxG.elapsed;
//            }
			
			for each (var patient : Patient in patients) {
				
//				if (patient.animationState == Patient.RUN) {
//					continue;
//				}
				
				var distance:Number = Math.abs(
                            Math.sqrt( Math.pow(patient.destination.x - patient.x, 2) + Math.pow(patient.destination.y - patient.y, 2) )
                        )
						
				if (distance < 1) {
					patient.new_distination();
				}
//				else if (patient.velocity.x < 1 && patient.velocity.x < 1) {
//					patient.new_distination();
//				}
//				
//				patient.velocity.x += ((patient.destination.x - patient.x) / 20) * FlxG.elapsed;
//				patient.velocity.y += ((patient.destination.y - patient.y) / 20) * FlxG.elapsed;

//				FlxVelocity.moveTowardsPoint(patient, patient.destination);
				
				
				var vel_x : Number = patient.velocity.x + ((patient.destination.x - patient.x) / 20) * FlxG.elapsed;
				var vel_y : Number = patient.velocity.y + ((patient.destination.y - patient.y) / 20) * FlxG.elapsed;
				
				if (previous_velocity.x != vel_x && previous_velocity.y != vel_y)
				{
					movement(patient, vel_x, vel_y);
					
					previous_velocity.x = patient.velocity.x;
					previous_velocity.y = patient.velocity.y;			
				}
			}
			
        }
        
        public function separate():void {
            var min_distance:uint = patient_size;
            
			for each (var patient : Patient in patients) {

                var x_adjustment:int = 0;
                var y_adjustment:int = 0;
                
				for each (var other_patient : Patient in patients) {

                    if (other_patient != patient) {
                        var distance:Number = Math.abs(
                            Math.sqrt( Math.pow(other_patient.x - patient.x, 2) + Math.pow(other_patient.y - patient.y, 2) )
                        )

                        if (distance < min_distance) {
                            x_adjustment -= (other_patient.x - patient.x);
                            y_adjustment -= (other_patient.y - patient.y);
                        }
                    }
                }

				var vel_x : Number = patient.velocity.x + x_adjustment / 2;
				var vel_y : Number = patient.velocity.y + y_adjustment / 2;

				if (previous_velocity.x != vel_x && previous_velocity.y != vel_y)
				{
					patient.velocity.x = vel_x;
                	patient.velocity.y = vel_y;
					
					previous_velocity.x = patient.velocity.x;
					previous_velocity.y = patient.velocity.y;					
				}
                
				
//				var vel_x : Number = patient.velocity.x + x_adjustment / 2;
//				var vel_y : Number = patient.velocity.y + y_adjustment / 2;
//				
//				movement(patient, vel_x, vel_y);
            }
        }

        public function align():void {
            for each (var patient : Patient in patients) {

                var x_adjustment:int = 0;
                var y_adjustment:int = 0;                
                
                for each (var other_patient : Patient in patients) {
                    if (other_patient != patient) {
                        x_adjustment += patient.velocity.x;
                        y_adjustment += patient.velocity.y;
                    }
                }

                x_adjustment = x_adjustment / (patients.length - 1);
                y_adjustment = y_adjustment / (patients.length - 1);

				
				var vel_x : Number = patient.velocity.x + (x_adjustment - patient.velocity.x) / 8;
				var vel_y : Number = patient.velocity.y + (y_adjustment - patient.velocity.y) / 8;

				if (previous_velocity.x != vel_x && previous_velocity.y != vel_y)
				{
					patient.velocity.x = vel_x;
                	patient.velocity.y = vel_y;
					
					previous_velocity.x = patient.velocity.x;
					previous_velocity.y = patient.velocity.y;
				}
				
//				var vel_x : Number = patient.velocity.x + (x_adjustment - patient.velocity.x) / 8;
//				var vel_y : Number = patient.velocity.y + (y_adjustment - patient.velocity.y) / 8;
//				
//				movement(patient, vel_x, vel_y);
            }
        }

        public function seek(target:FlxPoint, amount:Number, max_distance:uint = 10):void {
            for each (var patient : Patient in patients) {
                
                var distance:Number = Math.abs(
                    Math.sqrt( Math.pow(target.x - patient.x, 2) + Math.pow(target.y - patient.y, 2) )
                );

                if (distance > max_distance) {
                    patient.velocity.x += ((target.x - patient.x) * amount) * FlxG.elapsed;
                    patient.velocity.y += ((target.y - patient.y) * amount) * FlxG.elapsed;
                }
            }
		}
		
		
		public function flee(target:FlxPoint, amount:Number = -2, max_distance:uint = 100):void {
            for each (var patient : Patient in patients) {
                
                var distance:Number = Math.abs(
                    Math.sqrt( Math.pow(target.x - patient.x, 2) + Math.pow(target.y - patient.y, 2) )
                );
				
				trace("distance");
				trace(distance);

                if (distance < max_distance) {
                    patient.velocity.x *= amount;
                    patient.velocity.y *= amount;
                }
            }
		}
	}
}
