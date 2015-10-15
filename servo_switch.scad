/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

thickness = 5;
width = 60;
tube_dia = 6;

//pressure_wheel();
servo_mount();


module servo_mount() {
	union() {
		//base plate
		difference() {
			union() {
				translate([0, -5, 0]) cube(size=[width, 54, thickness], center=true);
				translate([0, -21, 2]) cube(size=[width, 22, thickness], center=true);
			}
			for(i=[-1, 1]) {
				translate([i*(width/2-8), 15, 0]) cylinder(r=3.3, h=20, center=true);
			}
		}
		//tube fitting
		translate([0, 4, 0]) {
			difference() {
				translate([0, 0, tube_dia+thickness/2]) cube(size=[width, tube_dia*2, tube_dia*2], center=true);
				cube(size=[40, 30, 30], center=true);
				translate([0, 0, thickness/2+tube_dia/2]) rotate([0, 90, 0]) cylinder(r=tube_dia/2+0.1, h=100, center=true);
			}
		}

		//servo mount (distance to tube center: ~22mm)
		difference() {
			translate([0, -22, 10+thickness/2+2]) cube(size=[width, 8, 20], center=true);
			translate([0, -8.5, 10+thickness/2]) cube(size=[41, 9, 21], center=true);
			#translate([0, -27.5, thickness/2+2]) servo();
		}
	}
}

module pressure_wheel() {
	difference() {
		cylinder(r=12, h=9, center=true);
		cylinder(r=1.65, h=10, center=true);
		for(i=[0, 2.4]){
			translate([0, 0, i]) cylinder(r=3.3, h=2.5, $fn=6, center=false);
		}
	}
}

module servo() {
	x = 40;
	y = 41;
	z = 20.5;

	color("Blue") translate([0, 0, z/2]) {
		difference() {
			union() {
				cube(size=[x, y, z], center=true);
				translate([0, 11, 0]) cube(size=[54.5, 2.5, z], center=true);
				translate([-10, y/2, 0]) rotate([-90, 0, 0]) cylinder(r=3.5, h=9, center=false);
				for(i=[-1, 1]) {
					for(j=[-1, 1]) {
						translate([i*25, 10, j*5]) rotate([90, 0, 0]) cylinder(r=1.95, h=30, center=true);
					}
				}
			}
		}
	}
}