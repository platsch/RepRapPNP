/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

include <RepRap-Industrial/configuration.scad>
use <RepRap-Industrial/x-carriage.scad>
use <camera_clip_sanyoHD2100P.scad>
include <../inc/syringe.scad>
include <../inc/nema.scad>
include <./vacuum_mount.scad>
include <./vacuum_mount_endstop.scad>
use <../inc/transmission_gears.scad>
use <../inc/cameras/sanyo/HD2100P.scad>



spindle_offset = 50;
syringe_z_offset = 17;

//override some variables from Kühling inc
x_carriage_syringe_body_length = 80+10;
body_length = 80;

/////////////// environtment objects ////////////////////////////////////

// RENDER X CARRIAGE
//rotate([0,-90,0]) x_carriage();
//#printer();

//translate([20, 0, 35]) rotate([0, 0, 180]) basler_ace();
//translate([20, 0, 35]) rotate([0, 0, 0]) rotate([0, 0, -90]) sanyo_HD2100P();

//syringe_idler();
//translate([-25, 45, x_carriage_body_height/2]) vacuum_mount_idler();
//translate([-25, 25, 60]) rotate([0, 0, -90]) vacuum_nema_mount();
//translate([-25, 0, 40]) rotate([0, 0, 90]) vacuum_mount_endstop(dia_out=20, dia_in=10, h=7);

//camera clip
//translate([45, -1, x_carriage_body_height/2+17.5]) camera_clip();
/////////////////////////////////////////////////////////////////////////


// Render combined syringe x carriage
x_carriage_combined();

module x_carriage_combined() {
	union() {
		// original x-carriage for filament extruders
		translate([-x_carriage_syringe_body_length-3, 0, 0])x_carriage();

		// x-carriage for syringe, camera, vacuum-gripper
	    difference() {
	        translate([-5, 0, 0]) x_carriage_syringe();

	        //vacuum gripper mods
	        translate([-25, 0, 0]) {
	        	//vacuum_gripper hole
	        	cylinder(r=6, h=100, center=true);
	        	//vacuum gripper upper ball bearing
	        	translate([0, 0, x_carriage_body_height/2-3]) cylinder(r=15/2+0.1, h=4, center=false);
	        	//vacuum gripper lower ball bearing
	        	translate([0, 0, -x_carriage_body_height/2+2]) cylinder(r=19/2+0.05, h=7, center=false);
	        }

	        //camera mods
			translate([20, 0, 0]) {
				//camera hole
	        	cylinder(r=18, h=100, center=true);
	        	//screws for LED ring
        		for(k=[0:3]) {
        			rotate([0, 0, 90*k]) translate([16, 16, -x_carriage_body_height/2]) cylinder(r=1.5, h=20, center=true);
        		}
	        	
	        }        

	    }
		//translate([-5, 0, 0]) x_carriage_connect();
		translate([0, -x_carriage_body_width/2-nema_11_xy/2, 30]) {
			//#translate([0, 0, -syringe_piston_length/2+syringe_z_offset]) syringe(luer_lock=true);
			syringe_mount();
		}
	    motor_mount();

	    translate([-25, 25, x_carriage_body_height/2]) vacuum_mount();
	    translate([20, 0, 0]) camera_mount_sanyo_HD2100P();
	    //translate([20, 0, 0]) camera_mount_basler_ace();
	}
}

module basler_ace() {
	import("../inc/cameras/basler/Basler ace GigE C-Mount v01.stl");
	rotate([0, -90, 0]) translate([-1, 0, 0]) import("../inc/cameras/basler/Basler Lens 8mm C-Mount v02.stl");
}

module sanyo_HD2100P() {
	translate([0, 0, 0]) HD2100P();
	rotate([0, -90, 0]) translate([-1, 0, 0]) import("../inc/cameras/basler/Basler Lens 8mm C-Mount v02.stl");
}

module printer() {
	translate([0, 0, 125+0.5]) cube(size=[300, 300, 1], center=true);
	translate([0, 0, -28-14.5-0.5]) cube(size=[300, 300, 1], center=true);
}

module vacuum_mount() {
	//pipette
	//#translate([0, -25, 0]) cylinder(r=9.6/2, h=100, center=true);;
	//translate([0, -25, 74]) rotate([0, 0, 90]) rotate([0, 0, 0]) transmission_gears(axis_dist=50, h=10, hub=6);

	//nema mount
	difference() {
		translate([0, -2, +9]) {
			cube(size=[nema_11_xy+20, nema_11_xy+4, 18], center=true);
		}
		//screws
		for(i=[-1, 1]) {
			translate([i*(nema_11_xy/2+5), nema_11_xy/2, 13]) {
				rotate([90, 0, 0]) cylinder(r=1.7, h=35, center=true);
				for(i=[0:2]) {
					translate([0, -10, i*2]) rotate([90, 0, 0]) rotate([0, 0, 30]) cylinder(r=3.4, h=3, center=true, $fn=6);
				}
			}
		}			
		#translate([0, 0, 46]) nema11();
	}
}

module vacuum_mount_idler() {
	cable_h = 6;
	offset = 18/2+cable_h/2;
	translate([0, 0, offset]) {
		difference() {
			cube(size=[nema_11_xy+20, 5, 18-cable_h], center=true);
			for(i=[-1, 1]) {
				translate([i*(nema_11_xy/2+5), 0, 13-offset]) rotate([90, 0, 0]) cylinder(r=1.8, h=20, center=true);
			}
		}
	}
}

module camera_mount_basler_ace() {
	translate([0, 20, x_carriage_body_height/2+35]) {
		difference() {
			cube(size=[40, 10, 70], center=true);
			translate([0, 0, 24.5]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
			for(i=[-1, 1]) {
				translate([i*10, 0, 24.5-23.7]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
			}
		}
	}
}

module camera_mount_sanyo_HD2100P() {
	translate([0, 42, x_carriage_body_height/2+25]) {
		difference() {
			cube(size=[40, 10, 50], center=true);
			for(i=[0, 1]) {
				translate([1, 0, 15-i*15]) {
                    rotate([0, 90, 0]) cylinder(r=1.7, h=40, center=true);
                    for(k=[0:2]) {
                        translate([5, k*3, 0]) rotate([0, 90, 0]) rotate([0, 0, 30]) cylinder(r=3.4, h=3, center=true, $fn=6);
                    }
                }
			}
			#translate([0, -42, -5]) rotate([0, 0, 0]) rotate([0, 0, -90]) sanyo_HD2100P();
		}
	}
}

module motor_mount() {
	h = 8;
	difference() {
		translate([0, -nema_11_xy/2+15/2-x_carriage_body_width/2, x_carriage_body_height/2-2+h/2]) cube(size=[body_length, nema_11_xy+15, h], center=true);
		translate([0, -x_carriage_body_width/2-nema_11_xy/2, x_carriage_body_height/2-2+h/2]) cube(size=[body_length-2*nema_11_xy-6, nema_11_xy, h], center=true);
		#translate([0, 0, -0.1]) motors();
	}
}

module motors() {
	translate([spindle_offset/2, -x_carriage_body_width/2-nema_11_xy/2, x_carriage_body_height/2]) nema11(screw_length = 20, screw_heads = false);
	translate([-spindle_offset/2, -x_carriage_body_width/2-nema_11_xy/2, x_carriage_body_height/2]) nema11(screw_length = 20, screw_heads = false);
}

module syringe_mount() {
	width = 30;
	grip_thickness = 12;
	grip_clearance = 0.2;
	syringe_dist = 0;
	syringe_dia = syringe_cylinder_dia+0.2;
	syringe_height = syringe_piston_length;
	luer_z_offset = syringe_height/2+syringe_luer_lock_length+1+15;

	//syringe top flange
	difference() {
		union() {
			//flange
			translate([0, 0, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+syringe_z_offset]) {
				hull() {
					translate([0, 18.7, 0]) cube(size=[body_length, 13, 10], center=true);
					for(i=[-1, 1]) {
						translate([i*body_length/2-i*10, 0, 0]) cylinder(r=10, h=10, center=true);
					}
				}
			}
			//wall
			translate([0, nema_11_xy/2+6, 10+syringe_z_offset/2]) cube(size=[body_length, 10, 50+syringe_z_offset], center=true);
		}

		//camera mount
		for(i=[0, 1]) {
			translate([body_length/2-5, nema_11_xy/2+6, 24.5-i*15]) {
                rotate([0, 90, 0]) cylinder(r=1.7, h=40, center=true);
                for(k=[0:2]) {
                    translate([-5, k*3, 0]) rotate([0, 90, 0]) rotate([0, 0, 30]) cylinder(r=3.4, h=3, center=true, $fn=6);
                }
            }
		}

		//syringe flange
		rotate([0, 0, 180]) {
			hull() {
				translate([0, syringe_dist, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+syringe_z_offset]) cylinder(r=syringe_dia/2+5.5, h=syringe_flange_height-0.3, center=true);
				translate([0, syringe_dist+2*syringe_dia, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+syringe_z_offset]) cylinder(r=syringe_dia/2+5.5, h=syringe_flange_height+0.3, center=true);
			}
			hull() {
				translate([0, syringe_dist, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+syringe_z_offset]) cylinder(r=syringe_dia/2+0.2, h=20, center=true);
				translate([0, syringe_dist+2*syringe_dia, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+syringe_z_offset]) cylinder(r=syringe_dia/2+0.2, h=20, center=true);
			}
		}

		//ball bearings
		for(i=[-1, 1]){ 
			translate([i*spindle_offset/2, 0, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+syringe_z_offset]) {
				translate([0, 0, 3]) cylinder(r=5.2, h=4.01, center=true);
				cylinder(r=4, h=20, center=true);
			}
		}
	}

	//syringe bottom grip
	translate([0, 0, syringe_z_offset]){
		difference() {
			translate([0, 8.5, -syringe_height/2-4]) cube(size=[20, 17, 16], center=true);
			translate([0, syringe_dist, -syringe_height/2]) cylinder(r=5+grip_clearance, h=40, center=true);
			//#cylinder(r=4.2, h=10, $fn=6, center=true);
			for(i=[-1, 1]) {
				translate([i*7, 10, -syringe_height/2-4]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
				for(j=[0:2]) {
					translate([i*7+i*2*j, 10, -syringe_height/2-4]) rotate([90, 0, 0]) cylinder(r=3.3, h=3.5, $fn=6, center=true);
				}
			}
		}
	}
}

module syringe_idler() {
	grip_clearance = 0.2;
	syringe_dist = 0;
	syringe_dia = syringe_cylinder_dia+0.2;
	syringe_height = syringe_piston_length;
	translate([0, -80, syringe_z_offset-23]){
		difference() {
			translate([0, -1, 0]) cube(size=[20, 16, 16], center=true);
			translate([0, 8, 0]) cylinder(r=5+grip_clearance, h=40, center=true);
			for(i=[-1, 1]) {
				translate([i*7, 10, 0]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
			}
		}
	}
}

module x_carriage_connect() {
	translate([-x_carriage_syringe_body_length/2, 0, -x_carriage_body_height/2]) {
		difference() {
			hull() {
				translate([6, 0, 1.5]) cube(size=[10, 32, 3], center=true);
				translate([0, 0, 1.5]) cube(size=[1, 32, 12], center=true);
				translate([-19, 0, 1.5]) cube(size=[1, 32, 12], center=true);
			}
			translate([-10, 0, 1.5]) cube(size=[20, 33, 3.1], center=true);
			for(i=[-1, 1]) {
				translate([-12, i*9, 0]) cylinder(r=2.1, h=20, center=true);
				translate([-12, i*9, 6]) cylinder(r=4.2, h=3.5, $fn=6, center=true);
			}
		}
	}
}

module x_carriage_syringe(){
	difference(){

		// main body
		union(){
			hull(){
				translate([-x_carriage_syringe_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
				translate([-x_carriage_syringe_body_length/2,x_carriage_body_width/2-wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
				translate([-x_carriage_syringe_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
				translate([-x_carriage_syringe_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
			}
			mirror([0,1,0]) hull(){
				translate([-x_carriage_syringe_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
				translate([-x_carriage_syringe_body_length/2,x_carriage_body_width/2-wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
				translate([-x_carriage_syringe_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
				translate([-x_carriage_syringe_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_syringe_body_length);
			}
			difference(){
				translate([-x_carriage_syringe_body_length/2,-x_rod_dist/2,-x_carriage_body_height/2])
					cube([x_carriage_syringe_body_length,x_rod_dist,x_carriage_body_height]);
				hull(){
					translate([-x_carriage_syringe_body_length/2-1,x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall,x_carriage_body_height/2-2*wall-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_syringe_body_length+2);
					translate([-x_carriage_syringe_body_length/2-1,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall),x_carriage_body_height/2-2*wall-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_syringe_body_length+2);
					translate([-x_carriage_syringe_body_length/2-1,x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall,-x_carriage_body_height/2+3*wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_syringe_body_length+2);
					translate([-x_carriage_syringe_body_length/2-1,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall),-x_carriage_body_height/2+3*wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_syringe_body_length+2);
				}
			}


			// zip tie slot for hot end cable fixation
			translate([0,x_rod_dist/2,0])
				for(i=[0,1])
					mirror([0,i,0])
						rotate([-i*90,0,0])
							translate([0,-linear_bearing_dia/2-clearance-wall+(frame_cable_mount_zip_tie_width+2*wall)/2,-x_carriage_body_height/2])
								difference(){
									hull(){
										translate([-frame_width/2+(frame_cable_mount_zip_tie_thickness+wall_thin),0,0])
											rotate([0,0,90])
												rotate([-90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
										translate([frame_width/2-(frame_cable_mount_zip_tie_thickness+wall_thin),0,0])
											rotate([0,0,90])
												rotate([90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
										translate([-frame_width/2+(frame_cable_mount_zip_tie_thickness+wall_thin)-wall,0,wall])
											rotate([0,0,90])
												rotate([-90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
										translate([frame_width/2-(frame_cable_mount_zip_tie_thickness+wall_thin)+wall,0,wall])
											rotate([0,0,90])
												rotate([90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
									}
									translate([-x_carriage_syringe_body_length/2,-frame_cable_mount_zip_tie_width/2,-frame_cable_mount_zip_tie_thickness])
										cube([x_carriage_syringe_body_length,frame_cable_mount_zip_tie_width,frame_cable_mount_zip_tie_thickness]);
								}
		}

		// linear bearing mounts
		difference(){
			for(i=[0,1])
				mirror([0,i,0]){
					translate([-x_carriage_syringe_body_length/2-1,x_rod_dist/2,0])
						rotate([0,90,0])
							cylinder(r=linear_bearing_dia/2+clearance_tight,h=x_carriage_syringe_body_length+2);
					hull(){
						translate([x_carriage_syringe_body_length/2-linear_bearing_length+2*wall-wall/2,x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
						translate([x_carriage_syringe_body_length/2-linear_bearing_length-2*wall+wall/2,x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
					}
					hull(){
						translate([-(x_carriage_syringe_body_length/2-linear_bearing_length+2*wall-wall/2),x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
						translate([-(x_carriage_syringe_body_length/2-linear_bearing_length-2*wall+wall/2),x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
					}
				}

			// linear bearing push in stop
			translate([-(x_carriage_syringe_body_length-2*linear_bearing_length-2*clearance)/2,-(x_carriage_body_width-2*wall)/2,linear_bearing_dia/2+clearance-wall_thin])
				cube([x_carriage_syringe_body_length-2*linear_bearing_length-2*clearance,x_carriage_body_width-2*wall,2*wall_thin]);
		}
	}

	if(support) mirror([0,1,0]){
		// belt tensioner screw hole printability support layer
		translate([x_carriage_syringe_body_length/2-(belt_tensioner_length+belt_tensioning_range/2)+(belt_tensioning_nut_height+2*clearance+wall_thin+clearance),x_belt_pulley_dia/2,0])
				rotate([180,0,0]) rotate([0,0,-90])
					translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
						rotate([-90,0,0])
							cylinder(r=belt_tensioning_screw_dia/2+clearance+wall_thin,h=layer_height);
	}
}





