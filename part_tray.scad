/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

// configuration variables
tray_height = 8; //hight of the base without rim
tray_notch_dist = 60.0; //for ground clamps. A high notch dist moves clamps to the side of the tray
rim_height = 0.5;
rim_width = 1.0;
box_size = 15;
rows = 3;
cols = 6;

tray_size_x = box_size*cols+rim_width*cols+rim_width;
tray_size_y = box_size*rows+rim_width*rows+rim_width;

// render trary
//part_tray(simple_clamps=true, nut_traps = false);
//base(simple_clamps=true, nut_traps = false);
//translate([0, 0, tray_height]) rim();

//slicing_box();

module part_tray(clamps = false, simple_clamps = false, nut_traps = true, render_screw = false) {
	base(clamps = clamps, simple_clamps=simple_clamps, nut_traps = nut_traps, render_screw = render_screw);
	translate([0, 0, tray_height]) rim();	
}

//base plate
module base(clamps = false, simple_clamps = false, nut_traps = true, render_screw = false) {
	difference() {
	    translate([-tray_size_x/2, -tray_size_y, 0]) {
	        union() {
	            cube(size=[tray_size_x, tray_size_y, tray_height], center=false);
	            if(clamps || simple_clamps) {
	                if(2*tray_notch_dist-6 > tray_size_x) {
	                    //move clamps to the side
	                    translate([tray_size_x/2+tray_notch_dist, tray_size_y-15/2, 0]) rotate([0, 0, -90]) clamp(15, ground_fix = clamps, nut_trap = nut_traps, render_screw = render_screw);
	                    translate([tray_size_x/2-tray_notch_dist, tray_size_y-15/2, 0]) rotate([0, 0, 90]) clamp(15, ground_fix = clamps, nut_trap = nut_traps, render_screw = render_screw);
	                }else{
	                    //clamps at opposite ends
	                    translate([tray_size_x/2+tray_notch_dist, tray_size_y+6, 0]) clamp(15, ground_fix = clamps, nut_trap = nut_traps, render_screw = render_screw);
	                    translate([tray_size_x/2-tray_notch_dist, tray_size_y+6, 0]) clamp(15, ground_fix = clamps, nut_trap = nut_traps, render_screw = render_screw);
	                }
	                translate([tray_size_x/2, -6, 0]) mirror([0, 1, 0]) clamp(15, ground_fix = clamps, nut_trap = nut_traps, render_screw = render_screw);
	            }
	        }
	    }
	    translate([0, 0, tray_height]) rim();
	}
}


module rim() {
	color("Blue") {
        translate([-tray_size_x/2, -tray_size_y, 0]) {
            union() {
                for(i=[0:rows]) {
                    translate([0, i*box_size+i*rim_width, -tray_height]) cube(size=[tray_size_x, rim_width, tray_height+rim_height], center=false);
                }
                for(i=[0:cols]) {
                    translate([i*box_size+i*rim_width, 0, -tray_height]) cube(size=[rim_width, tray_size_y, tray_height+rim_height], center=false);
                }
            }
        }
	}
}


module clamp(width, ground_fix = false, nut_trap = true, render_screw = false) {
	wall_dia = 6;
	height = tray_height;
	translate([0, -6, 0]) {
		difference() {
			union() {
				hull() {
					translate([0, -2, height/2]) cube(size=[width, 30, height], center=true);	
					if(ground_fix) {
						translate([0, 28, 2.5]) cube(size=[width, 12, 5], center=true);
					}
				}
				if(ground_fix) {
					translate([0, 40, 2.5]) difference() {
						cube(size=[width, 14, 5], center=true);
						cylinder(r=3.2, h=20, center=true);
					}
				}
				if(render_screw) {
					translate([0, 6, 0]) cylinder(r=1.8, h=40, center=true);
				}
			}

			//screw
			translate([0, 6, 0]) {
				//M4
				/*
				if(!render_screw) cylinder(r=2.3, h=40, center=true);
				//#translate([0, 0, tray_height]) cylinder(r=4.2, h=15, center=false);
				translate([0, 0, height/2]) {
					for(i=[0:3]) {
						if(nut_trap) {
							translate([i*4.0, 0, 0]) cylinder(r=4.3, h=3.3, center=true, $fn=6);
						}else{
							if(!render_screw) translate([0, 0, i*4.0]) cylinder(r=4.3, h=3.3, center=true, $fn=6);
						}
					}
				}
				*/
				//M3
				
				if(!render_screw) cylinder(r=1.8, h=40, center=true);

				//translate([0, 0, tray_height]) cylinder(r=4.2, h=15, center=false);
				translate([0, 0, height/2]) {					
					for(i=[0:3]) {
						if(nut_trap) {
							translate([i*3.0, 0, 0]) cylinder(r=3.3, h=3.5, $fn=6, center=true);
						}else{
							if(!render_screw) translate([0, 0, i*3.0]) cylinder(r=3.3, h=3.5, $fn=6, center=true);
						}
					}
				}
			}
		}
	}
}


// this can be used to generate a box to be printed by the second (brim) extruder to prevent clogging of the nozzle.
module slicing_box() {
	translate([0, 0, tray_height/2]) cube(size=[20, 20, tray_height], center=true);
}