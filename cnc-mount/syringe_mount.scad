use <../inc/nema.scad>
use <../inc/Flexible_Coupling_param.scad>
use <../inc/Thread_Library.scad>
use <../inc/transmission_gears.scad>
use <../inc/heat_block.scad>


// general object resolution
$fn = 50;

// the extruder design heavily depends on the shape of the syringe
// and therefore uses the configuration values from inc/syringe to
// generate the parts. Make sure those values fit your syringe precisely!
include <../inc/syringe.scad>

//#######important basic options##########//
single = false;  //one or two spindle drive?
double_drive = true; //one motor and gears or double motor drive
heated = false;   //heated syringe or usage at room temp?

//global options
nema_xy = 42;
spindle_offset = 50;      //distance of threaded rod drives, affects gear size
axis_offset = 26;		  //space between Z-axis and motor axis
syringe_axis_offset = single ? 17 : 0; //space between motor axis and syringe axis
heat_block_offset = -3.5; //heat blocks luer offset
heat_block_h = 25;



show_assembly();
//make_parts();


module make_parts(){
	if(single) {
		 translate([0, 0, nema_xy/2+1.5]) rotate([0, 90, 0]) motor_mount();
		 translate([20, 30, 0]) flexible_coupling();
		 translate([-8, -10, 0]) syringe_drive();
		 translate([-50, 80, 0]) rotate([90, 0, -90]) syringe_mount(single=false);
		 translate([0, 50, 6]) rotate([-90, 0, 0]) syringe_idler();
		 translate([0, -30, 0]) transmission_gears(axis_dist=spindle_offset, h=7, hub=6, assembled=false);
	}else{
		 //translate([50, 50, 0]) rotate([90, 0, 0]) motor_mount();
		 //translate([-25, 0, 0]) syringe_drive(single=false);
		 //translate([-50, 80, 0]) rotate([90, 0, -90]) syringe_mount(thickness = 10);
		 translate([17, 50, 6]) rotate([-90, 0, 0]) syringe_idler();
		 //translate([-10, -30, 11]) transmission_gears(axis_dist=spindle_offset, h=10, hub=6, assembled=false);
	}

}

module show_assembly() {
	if(single) {
		environment();  //provides motor, z-axis etc
		translate([0, 0, syringe_piston_length/2]) motor_mount();
		translate([0, axis_offset, syringe_piston_length-10]) rotate([0, 180, 0]) flexible_coupling();
		translate([0, 0, syringe_piston_length/4]) syringe_drive();
		syringe_mount(thickness = 12);
		translate([0, 50, -90]) syringe_idler();
	}else{
		environment();  //provides motor, z-axis etc
		translate([0, 0, syringe_piston_length/2]) motor_mount();
		translate([0, 0, syringe_piston_length/4]) syringe_drive();
		syringe_mount(thickness = 10);
		translate([0, 33, -syringe_piston_length]) syringe_idler();
		if(!double_drive) {
			translate([-spindle_offset/2, axis_offset, syringe_piston_length-20]) rotate([180, 0, 0]) transmission_gears(axis_dist=spindle_offset, h=10, hub=6);			
		}
	}
}


module motor_mount(thickness = 8) {
	additional_width = double_drive ? nema_xy : 15;
	width = single ? nema_xy+3 : spindle_offset+additional_width;

	difference() {
		translate([0, nema_xy/2+thickness/2, 31.6]) {
			difference() {
				cube(size=[width, nema_xy+thickness, 40], center=true);
				translate([0, thickness/2+0.1, -thickness/2-0.1]) cube(size=[width+1, nema_xy, 40-thickness], center=true);
			}
		}
		//motor screws and shaft
		if (double_drive) {
			translate([spindle_offset/2, axis_offset, 50]) rotate([0, 180, 0]) nema17(6, true);
			translate([-spindle_offset/2, axis_offset, 50]) rotate([0, 180, 0]) nema17(6, true);
		}else{
			translate([0,26, 50]) rotate([0, 180, 0]) nema17(6, true);
		}

		//x-axis screw
		for(i=[0, 1]) {
			translate([0, thickness/2, 20+i*17]) {
				rotate([90, 0, 0]) {
					cylinder(r=3.5, h=thickness+1, center=true);
					translate([0, 0, -thickness/2+thickness/4-0.2]) cylinder(r=6, h=thickness/2, center=true);
				}
			}
		}

		//threaded rod bearing
		if(!single){
			for(i=[-1,1]) {
				translate([i*spindle_offset/2, axis_offset, 48]) cylinder(r=4.3, h=thickness+5, center=true);
			}
		}
	}
}

module syringe_drive(screw_mount=false) {
	translate([0, axis_offset, 5]) {
		difference() {
			union() {
				//trapez nut
				if (single) {
				    translate([0, 0, -5]) {
				      trapezoidNut(
				        length=10,        // axial length of the threaded rod 
				        radius=10,         // outer radius of the nut  
				        pitch=2,        // axial distance from crest to crest
				        pitchRadius=4.45, //4.75     // radial distance from center to mid-profile
				        threadHeightToPitch=0.5,  // ratio between the height of the profile and the pitch
				                  // std value for Acme or metric lead screw is 0.5
				        profileRatio=0.5,       // ratio between the lengths of the raised part of the profile and the pitch
				                  // std value for Acme or metric lead screw is 0.5
				        threadAngle=30,       // angle between the two faces of the thread 
				                  // std value for Acme is 29 or for metric lead screw is 30
				        RH=true,        // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
				        countersunk=0.5,    // depth of 45 degree chamfered entries, normalized to pitch
				        clearance=0.1,      // radial clearance, normalized to thread height
				        backlash=0.1,       // axial clearance, normalized to pitch
				        stepsPerTurn=24       // number of slices to create per turn
				      );
					}
				}else{
					for(i=[-1,1]) {
						translate([spindle_offset*i/2, 0, -5]) {
					      trapezoidNut(
					        length=10,        // axial length of the threaded rod 
					        radius=10,         // outer radius of the nut  
					        pitch=2,        // axial distance from crest to crest
					        pitchRadius=4.45, //4.75      // radial distance from center to mid-profile
					        threadHeightToPitch=0.5,  // ratio between the height of the profile and the pitch
					                  // std value for Acme or metric lead screw is 0.5
					        profileRatio=0.5,       // ratio between the lengths of the raised part of the profile and the pitch
					                  // std value for Acme or metric lead screw is 0.5
					        threadAngle=30,       // angle between the two faces of the thread 
					                  // std value for Acme is 29 or for metric lead screw is 30
					        RH=true,        // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
					        countersunk=0.5,    // depth of 45 degree chamfered entries, normalized to pitch
					        clearance=0.1,      // radial clearance, normalized to thread height
					        backlash=0.1,       // axial clearance, normalized to pitch
					        stepsPerTurn=24       // number of slices to create per turn
					      );
						}
					}
				}
				//main block
				if(single) {
					difference() {
						translate([0, 10, 0]) cube(size=[22, 20, 10], center=true);
						cylinder(r=7, h=12, center=true);
					}
				}else{
					difference() {
						cube(size=[spindle_offset, 18, 10], center=true);
						for(i=[1, -1]) {
							translate([spindle_offset*i/2, 0, 0]) cylinder(r=7, h=12, center=true);
						}
					}
				}
			}
			if(screw_mount) { //cut away some material to make a slot for the syringe flange
		    	translate([0, syringe_axis_offset, -2]) hull() {
		    		cylinder(r=4, h=8, center=true);
		    		translate([0, 10, 0]) cylinder(r=4, h=8, center=true);

		    	}
		    	translate([0, syringe_axis_offset, 0]) {
		    		hull() {
			    		rotate_extrude(convexity = 10, $fn = 30)
						translate([13.5/2, 0, 0])
						circle(r = 4.2/2, $fn = 30);
						translate([0, 8, 0]) {
							rotate_extrude(convexity = 10, $fn = 30)
							translate([13.5/2, 0, 0])
							circle(r = 4.2/2, $fn = 30);
						}
					}
			    }
			}else{ //syringe has a screwhole in its head
				cylinder(r=2.1, h=11, center=true);
			}
		}
	}
}

module syringe_mount(thickness = 8) {
	width = 30;
	grip_thickness = 12;
	grip_clearance = heated ? 1.2 : 0.2;
	syringe_dist = axis_offset+syringe_axis_offset;
	syringe_dia = syringe_cylinder_dia+0.2;
	syringe_height = syringe_piston_length;
	luer_z_offset = syringe_height/2+syringe_luer_lock_length+1+15;

	translate([0, 0, -syringe_height/2]) {
		difference() {
			union() {
				//main block
				translate([0, thickness/2, 5]) cube(size=[width, thickness, syringe_height+5], center=true);

				//top mount
				if(single) {
					translate([0, (syringe_dist+5)/2, syringe_height/2-syringe_piston_offset-syringe_flange_height/2]) cube(size=[width, syringe_dist+5, 10], center=true);
				}else{
					translate([0, (syringe_dist+8)/2, syringe_height/2-syringe_piston_offset-syringe_flange_height/2]) cube(size=[spindle_offset+16, syringe_dist+8, 10], center=true);
				}

				//bottom mount
				translate([0, syringe_dist/2, -syringe_height/2+5+1]) cube(size=[syringe_dia+2*grip_thickness, syringe_dist, 10], center=true);

				//heat block mount
				if(heated) {
					difference() {
						translate([0, 0, 1]) {
							hull(){
								translate([0, 0.5, -syringe_height/2-syringe_luer_lock_length/2-3]) cube(size=[syringe_dia+2*grip_thickness, 1, syringe_luer_lock_length+6], center=true);
								translate([0, syringe_dist-5, -syringe_height/2-syringe_luer_lock_length/2-25/2]) cube(size=[syringe_dia+2*grip_thickness, 10, syringe_luer_lock_length+25], center=true);
							}
						}
						translate([heat_block_offset, 0, -syringe_height/2-20]) {
							cube(size=[16, 100, 50], center=true);
						}
					}
				}
			}

			//syringe top flange
			hull() {
				translate([0, syringe_dist, syringe_height/2-syringe_piston_offset-syringe_flange_height/2]) cylinder(r=syringe_dia/2+5.5, h=syringe_flange_height, center=true);
				translate([0, syringe_dist+2*syringe_dia, syringe_height/2-syringe_piston_offset-syringe_flange_height/2]) cylinder(r=syringe_dia/2+5.5, h=syringe_flange_height+0.5, center=true);
			}
			hull() {
				translate([0, syringe_dist, syringe_height/2-syringe_piston_offset-syringe_flange_height/2]) cylinder(r=syringe_dia/2+0.2, h=20, center=true);
				translate([0, syringe_dist+2*syringe_dia, syringe_height/2-syringe_piston_offset-syringe_flange_height/2]) cylinder(r=syringe_dia/2+0.2, h=20, center=true);
			}

			//syringe bottom grip
			translate([0, syringe_dist, -syringe_height/2+5]) cylinder(r=syringe_dia/2+grip_clearance, h=40, center=true);
			translate([0, syringe_dist+syringe_dia/2, -syringe_height/2+5]) cube(size=[syringe_dia+grip_clearance, syringe_dia, 11], center=true);
			//translate([0, syringe_dist, -syringe_height/2+5]) {
			//	difference() {
			//		translate([0, syringe_dia/2, 0]) cube(size=[width, syringe_dia, 11], center=true);
			//		cylinder(r=(syringe_dia+2*grip_thickness)/2, h=10, center=true);
			//	}
			//}

			//heat block mount
			translate([0, syringe_dist+2*heat_block_offset, -luer_z_offset]) {
				rotate([0, 90, 0]) cylinder(r=2.8, h=50, center=true);
				translate([15, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30]) cylinder(r=4.8, h=5, center=true, $fn=6);
			}

			//idler
			for(i = [-1, 1]) {
				translate([i*(syringe_dia/2+grip_thickness/2), syringe_dist, -syringe_height/2+5]) rotate([90, 0, 0]) {
					cylinder(r=2, h=70, center=true);
					for(j = [0:2])
					translate([i*j*2, 0, 15]) cylinder(r=3.5, h=3.5, center=true, $fn=6);
				}
			}

			//threaded rod bearing (5x4x10 ball bearings)
			if(single){
				translate([0, axis_offset, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+5-2]) {
					cylinder(r=5.2, h=4.01, center=true);
					cylinder(r=4, h=5, center=true);
				}
			}else{
				for(i=[-1,1]) {
					translate([i*spindle_offset/2, axis_offset, syringe_height/2-syringe_piston_offset-syringe_flange_height/2+5-2]) {
						cylinder(r=5.2, h=4.01, center=true);
						cylinder(r=4, h=5, center=true);
					}
				}
			}

			//x-axis screws
			for(i=[-1, 0.8, 1.95]) {
				translate([0, thickness/2, i*syringe_height/4]) {
					rotate([90, 0, 0]) {
						cylinder(r=3.5, h=thickness+1, center=true);
						translate([0, 0, -thickness/2+thickness/4-0.2]) cylinder(r=6, h=thickness/2, center=true);
					}
				}
			}
		}
	}
}

module syringe_idler() {
	syringe_dia = syringe_cylinder_dia;
	difference() {
		cube(size=[30, syringe_dia, 10], center=true);
		translate([0, -syringe_dia/2-0.4]) cylinder(r=syringe_dia/2+0.2, h=15, center=true);
		for(i = [-1, 1]) {
			translate([i*10, 0, 0]) rotate([90, 0, 0]) cylinder(r=2, h=30, center=true);
		}
	}
}

module environment() {
	color("Blue") union() {
		//stepper motor
		if(single) {
			translate([0, axis_offset, syringe_piston_length]) rotate([0, 180, 0]) nema17(12);
		}else{
			if(double_drive) {
				translate([spindle_offset/2, axis_offset, syringe_piston_length]) rotate([0, 180, 0]) nema17(12);
				translate([-spindle_offset/2, axis_offset, syringe_piston_length]) rotate([0, 180, 0]) nema17(12);
			}else{
				translate([0, axis_offset, syringe_piston_length]) rotate([0, 180, 0]) nema17(12);
			}
		}

		//z-axis
		translate([0, -5, 0]) cube(size=[60, 10, 300], center=true);

		//syringe
		translate([0, axis_offset+syringe_axis_offset, -syringe_piston_length]) syringe();

		//thread_rod
		if(single) {
			translate([0, axis_offset, syringe_piston_length/2-syringe_piston_offset/2]) cylinder(r=5, h=syringe_piston_length, center=true);
		}else{
			for(i=[1, -1]) {
				translate([spindle_offset*i/2, axis_offset, syringe_piston_length/2-syringe_piston_offset/2]) cylinder(r=5, h=syringe_piston_length, center=true);
			}
		}

		//syringe_heat_block
		if (heated) {
			translate([heat_block_offset, axis_offset+syringe_axis_offset-abs(heat_block_offset), -syringe_piston_length-syringe_luer_lock_length-1]) {  
				rotate([0, 0, 180]) heat_block(luer_offset=heat_block_offset, w=15, h=heat_block_h, tip="luer");
			}	
		}
	}
}