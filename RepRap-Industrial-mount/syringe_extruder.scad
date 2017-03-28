/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de> 
Maintainer: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

include <RepRap-Industrial/configuration.scad>
include <../inc/syringe.scad>
include <../inc/nema.scad>

spindle_offset = 50;
syringe_z_offset = 17;

//override some variables from Kühling inc
x_carriage_syringe_body_length = 80+10;
body_length = 80;

syringe_extruder();

module syringe_extruder() {
    difference(){
	    union(){
		    	translate([0, -x_carriage_body_width/2-nema_11_xy/2, 30]) {
		        %translate([0, 0, -syringe_piston_length/2+syringe_z_offset]) syringe(luer_lock=true);
		        syringe_mount();
		    }
		    motor_mount();
		    %translate([0, 0, -0.1]) motors();
		}
	}

}

module motor_mount() {
	h = 8;
	difference() {
		translate([0, -nema_11_xy/2+11/2-x_carriage_body_width/2, x_carriage_body_height/2-2+h/2]) cube(size=[body_length, nema_11_xy+11, h], center=true);
		translate([0, -x_carriage_body_width/2-nema_11_xy/2, x_carriage_body_height/2-2+h/2]) cube(size=[body_length-2*nema_11_xy-6, nema_11_xy, h], center=true);
		translate([0, 0, -0.1]) motors();
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
		for(k=[-1,0,1]){
			translate([k*25,0,0])
			for(i=[-1,1]){
	        	for(j=[-1,1]){
	        		//RobotDigg
	            	translate([j*7.5,16.2,syringe_z_offset/2+i*5])rotate([90,0,0])cylinder(h=30*3, r=3.3/2, center=true);
	            	translate([j*7.5,16.2,syringe_z_offset/2+i*5])rotate([90,0,0])cylinder(h=2, r=6/2, center=true);
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
			translate([0, 8.5, -syringe_height/2-4+18.2/2]) cube(size=[20, 17, 16+18.2], center=true);
			translate([0, syringe_dist, -syringe_height/2]) cylinder(r=5+grip_clearance, h=60, center=true);
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