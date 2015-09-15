/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

use <../inc/nema.scad>
use <../inc/transmission_gears.scad>


// general object resolution
$fn = 50;

bb_dia = 35.5;

//needle_shield();

//translate([0, 0, -8]) lower_mount();
//translate([0, 0, 100]) top_mount();

//mount_plate();
//translate([0, 0, -15]) pipette();

//translate([0, 0, 75]) ballbearing();
//translate([0, 0, -8-11]) ballbearing();

//translate([0, 0, 60]) rotate([0, 0, 90]) rotate([0, 0, 0]) transmission_gears(axis_dist=50, h=10, hub=6);

//upper_vacuum_mount();

module upper_vacuum_mount() {
	difference() {
		union() {
			cylinder(r=33, h=10, center=false);
			translate([-25, 5, 0]) cube(size=[50, 45, 20], center=false);
			for(i=[-1, 1]) {
				translate([i*38, 0, 0]) cylinder(r=8, h=77, center=false);
			}
		}
		#translate([0, 25, 50]) rotate([0, 0, 0]) nema11();

		//hole
		cylinder(r=8, h=50, center=true);

		//screws
		for(i=[-1, 1]) {
			translate([i*25, 0, 0]) cylinder(r=2.2, h=30, center=true);
		}

		//upper ball bearing screws
		for(i=[-1, 1]) {
			translate([i*38, 0, 35]) cylinder(r=2, h=45, center=false);
		}
	}
}


module top_mount() {
	difference() {
		union() {
			difference() {
				translate([0, 0, -15]) cylinder(r=42/2, h=15, center=false);
				cylinder(r=25/2, h=35, center=true);
			}
			for(i=[-1, 1]) {
				hull() {
					translate([i*20, 0, -15]) cylinder(r=8, h=15, center=false);
					translate([i*38, 0, -15]) cylinder(r=8, h=15, center=false);
				}
			}
			//uniform background for image processing
		}

		//ball bearing
		translate([0, 0, -11]) cylinder(r=bb_dia/2, h=11.5, center=false);

		//screws
		for(i=[-1, 1]) {
			translate([i*38, 0, -16]) cylinder(r=2.3, h=30, center=false);
		}
	}
}


module lower_mount() {
	difference() {
		union() {
			difference() {
				translate([0, 0, -15]) cylinder(r=42/2, h=15, center=false);
				cylinder(r=25/2, h=35, center=true);
			}
			for(i=[-1, 1]) {
				translate([i*25, 0, -15]) cylinder(r=8, h=15, center=false);
			}
			//uniform background for image processing
			translate([0, 0, -15]) cylinder(r=42/2+6, h=2.5, center=false);
		}

		//ball bearing
		translate([0, 0, -11]) cylinder(r=bb_dia/2, h=11.5, center=false);

		cylinder(r=3.5, h=35, center=true);

		//screws
		for(i=[-1, 1]) {
			translate([i*25, 0, -16]) cylinder(r=2.3, h=20, center=false);
			//M4
			translate([i*25, 0, -16]) cylinder(r=4.2, h=4.0, center=false, $fn=6);
		}
	}
}

module mount_plate() {
	difference() {
		translate([0, 0, -4]) cube(size=[150, 150, 8], center=true);
		cylinder(r=21.5/2, h=20, center=true);
		for(i=[-1, 1]) {
			translate([i*25, 0, 0]) cylinder(r=3, h=20, center=true);
		}
	}	
}

module ballbearing() {
	difference() {
		cylinder(r=35.4/2, h=11, center=false);
		translate([0, 0, -0.5]) cylinder(r=10/2, h=12, center=false);
	}
}

module pipette() {
	color("Blue") union() {
		cylinder(r=5, h=100, center=false);
		translate([0, 0, -18]) cylinder(r=4, h=18.1, center=false);
		translate([0, 0, -17-18]) cylinder(r=1.5/2, h=17.1, center=false);
	}
}

module needle_shield(dia = 2.0) {
	difference() {
		cylinder(r=10, h=1.5, center=true);
		cylinder(r=dia/2, h=2, center=true);
	}
}