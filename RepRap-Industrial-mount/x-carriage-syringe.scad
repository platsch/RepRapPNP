/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

include <RepRap-Industrial/configuration.scad>
//use <RepRap-Industrial/x-carriage.scad>
use <x-carriage-single.scad>
use <servo_mount.scad>
use <mechanical_stop.scad>
use <pnp_motor_mount.scad>
use <syringe_extruder.scad>
include <../inc/syringe.scad>
include <../inc/nema.scad>
use <../inc/led_ring/led_ring_head.scad>
use <../inc/transmission_gears.scad>
include<../inc/pnp_head.scad>

spindle_offset = 50;
syringe_z_offset = 17;

//override some variables from Kühling inc
x_carriage_syringe_body_length = 80+10;
body_length = 80;

//camera led ring
translate([20, 0, -x_carriage_body_height/2-5]) {
    %led_ring_base();
    %rotate([0,180,0])led_ring_circuit();
}
/////////////////////////////////////////////////////////////////////////


// Render combined syringe x carriage
x_carriage_combined();

module x_carriage_combined() {
	union() {
		// original x-carriage for filament extruders
		translate([-x_carriage_syringe_body_length/2-9.5, 0, 0])x_carriage_single();

		// x-carriage for syringe, camera, vacuum-gripper
	    difference() {
	        union(){
	        	translate([-5, 0, 0]) x_carriage_syringe();
	        	translate([-21/2,-x_carriage_body_width/2,-x_carriage_body_height/2]) cube(size=[21,4,7], center=false);
	        }

	        //syringe mechanical_stop leftout & mounting holes
	        translate([-21/2,-x_carriage_body_width/2-5-4,-x_carriage_body_height/2])union() {
		        for(i=[-1,1]){
		        	for(j=[0:6]){
			        	translate([21/2+i*13/2,3.5+8.5+3,10/2-1*j])rotate([90,90,0])cylinder(h=2.8, r=6.6/2, center=false, $fn=6);
			        }
		        	translate([21/2+i*13/2,14.5,10/2])rotate([90,0,0])cylinder(h=14.5, r=3.5/2, center=false);
		        }
		    }

	        //vacuum gripper mods
	        translate([-30, 0, 15]) {
                cube([28.5+2*3+2*2,28.5+15,20],center=true);
	        }
            translate([-30, 0, -15]) {
                cube([28.5+11.51,28.5+14.7,20],center=true);
	        }
	        //pnp mechanical_stop leftout & mounting holes
	        translate([-30,3.7,39.2-4.5])translate([-21/2,12.6-2.5+1,-48.9])union() {
		       translate([-0.4/2,0,-0.4/2]) cube([21+0.4,5+4,10+0.4]);
		        for(i=[-1,1]){
		        	for(j=[0:6]){
			        	translate([21/2+i*13/2,3.5+8+3,10/2-1*j])rotate([90,90,0])cylinder(h=2.8, r=6.6/2, center=false, $fn=6);
			        }
		        	translate([21/2+i*13/2,14.5,10/2])rotate([90,0,0])cylinder(h=14.5, r=3.5/2, center=false);
		        }
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

        syringe_slide_mount();
        translate([-21/2,-x_carriage_body_width/2-5-4,-x_carriage_body_height/2]) {
            %mechanical_stop(30);
        }
        translate([0,-x_carriage_body_width/2+8.5,x_carriage_body_height/2]) rotate([90,0,0]) {
            %import("../inc/igus/NS_01_27_100_1.stl");
            %translate([0,50,0]) import("../inc/igus/NW_01_27_2.stl");
        }
        %translate([0,-21+8.5,0])syringe_extruder();


        //vaccum pnp
        translate([-30,2.7,39.2-4.5]) {
            translate([-21/2,12.6-2.5+2,-48.9]) {
                %mechanical_stop(30);
            }
            translate([0,22+9.5,-35]){
                pnp_slide_mount();
            }
            translate([0,-1.5,-6.5-5+5]){
	            %pnp_motor_mount();
	            %translate([0,-3,0]) pnp_head();
	        }
            translate([0,26.5,0])rotate([90,0,0]) {
                %translate([0,-20.5,0])import("../inc/igus/NS_01_27_100_1.stl");
                %translate([0,0,0])import("../inc/igus/NW_01_27_2.stl");
            }
        }

        //camera mount
	    translate([20, 0, 0]) camera_mount_basler_ace();
	}
}

module printer() {
	translate([0, 0, 125+0.5]) cube(size=[300, 300, 1], center=true);
	translate([0, 0, -28-14.5-0.5]) cube(size=[300, 300, 1], center=true);
}

module syringe_slide_mount() {
    translate([40-body_length/2, -x_carriage_body_width/2+10/2+0.15+8.5, x_carriage_body_height/2+100/2]) {
		difference() {
			union(){
				cube(size=[80, 10, 100], center=true);
				for(i=[-1, 1]) {
					hull(){
						translate([i*37.5-2.5,5,49.9])cube([5,0.1,0.1]);
						translate([i*37.5-2.5,5,-50.1])cube([5,9,0.1]);

					}
				}
			}
            for(k=[-1,0,1]){
            	translate([k*25,0,0])
	            for(i=[-1, 1]) {
	                //robotdig linear rail
	                translate([0, 0, i*20]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
	                translate([0,10-6,i*20]) rotate([90, 0, 0]) cylinder(h=3, r=6.8/2, center=true, $fn=6);
	            }
	        }
            translate([0,-(10-4.2)/2,(100-15.2)/2]){
	            cube([80.2,4.3,15.3], center=true);
           		for(i=[-1, 1]) {
                	translate([i*10, 0, 0]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
                	translate([i*10,10-3,0]) rotate([90, 0, 0]) cylinder(h=3, r=6.8/2, center=true, $fn=6);
            	}
	        }
	        translate([-42.5,5.2,14])cube([85,frame_cable_mount_zip_tie_thickness,frame_cable_mount_zip_tie_width]);
			translate([-42.5,5.2+3,-25])cube([85,frame_cable_mount_zip_tie_thickness,frame_cable_mount_zip_tie_width]);
		}
		%translate([0,-(10-4)/2,(100-20)/2])rotate([90,0,0])servo_mount();
	}
}

module pnp_slide_mount() {
    translate([0,0, x_carriage_body_height/2+(100)/2]) {
		difference() {
			union(){
				cube(size=[40, 10, 100], center=true);
				for(i=[-1, 1]) {
					hull(){
						translate([i*17.5-2.5,5,49.9])cube([5,0.1,0.1]);
						translate([i*17.5-2.5,5,-50.1])cube([5,9,0.1]);

					}
				}
			}
            for(i=[-1, 1]) {
                //robotdig
                translate([0, 0, i*20]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
                translate([0,10-6,i*20]) rotate([90, 0, 0]) cylinder(h=3, r=6.8/2, center=true, $fn=6);
                //igus 27mm
                translate([0, 0, i*30]) rotate([90, 0, 0]) cylinder(r=2.2, h=40, center=true);
                translate([0,10-6,i*30]) rotate([90, 0, 0]) cylinder(h=3.5, r=8.5/2, center=true, $fn=6);
            }
            translate([0,-(10-4.2)/2,(100-15)/2]){
	            cube([40.2,4.3,15.3], center=true);
           		for(i=[-1, 1]) {
                	translate([i*10, 0, 0]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
                	translate([i*10,10-3,0]) rotate([90, 0, 0]) cylinder(h=3, r=6.8/2, center=true, $fn=6);
            	}
	        }
	        translate([-22.5,5.2,14])cube([45,frame_cable_mount_zip_tie_thickness,frame_cable_mount_zip_tie_width]);
			translate([-22.5,5.2+3,-25])cube([45,frame_cable_mount_zip_tie_thickness,frame_cable_mount_zip_tie_width]);
		}
		%translate([0,-(10-4)/2,(100-20)/2])rotate([90,0,0])servo_mount();
	}
}

module basler_ace() {
	import("../inc/cameras/basler/Basler ace GigE C-Mount v01.stl");
	rotate([0, -90, 0]) translate([-1, 0, 0]) import("../inc/cameras/basler/Basler Lens 8mm C-Mount v02.stl");
}

module camera_mount_basler_ace() {
	translate([0, 20, x_carriage_body_height/2+35]) {
		difference() {
			union(){
				cube(size=[40, 10, 70], center=true);
				for(i=[-1, 1]) {
					hull(){
						translate([i*17.5-2.5,5,34.9])cube([5,0.1,0.1]);
						translate([i*17.5-2.5,5,-35.1])cube([5,9,0.1]);

					}
				}
			}
			translate([0, 0, 15+23.7-15]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
			translate([0,10-6,15+23.7-15]) rotate([90, 0, 0]) cylinder(h=3, r=6.8/2, center=true, $fn=6);
			for(i=[-1, 1]) {
				translate([i*10, 0, 15-15]) rotate([90, 0, 0]) cylinder(r=1.7, h=40, center=true);
				translate([i*10,10-6,15-15]) rotate([90, 0, 0]) cylinder(h=3, r=6.8/2, center=true, $fn=6);
			}
			translate([-22.5,5.2,8])cube([45,frame_cable_mount_zip_tie_thickness,frame_cable_mount_zip_tie_width]);
			translate([-22.5,5.2+3,-20])cube([45,frame_cable_mount_zip_tie_thickness,frame_cable_mount_zip_tie_width]);
        //%translate([0, -20, -15])rotate([0, 0, 180]) basler_ace();
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





