/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@informatik.uni-hamburg.de>
Maintainer: Florens Wasserfall <wasserfall@kalanka.de>
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html'
*******************************************************/

$fn=50;

probe_mount();

module probe_mount() {
	w=24;
	difference() {
		union() {
    		cube(size=[w, 4, 10], center=false);
    		translate([0, 3, 3.9]) cube(size=[w, 13, 4.1], center=false);
    	}
    	// endstop mount
    	translate([2, -7, 0]) endstop(screws=true);

    	//bed mount
    	for(i=[-1, 1]) {
    		translate([w/2+i*6, 10, 7]) {
    			cylinder(h=20, r=1.8, center=true);
    			rotate([0, 0, 30]) cylinder(h=2.6, r=3.3, center=true, $fn=6);
    		}
    	}
    }
}

module endstop(screws = false) {
	w = 20;
	d = 6.4;
	h = 10;
	hole_d = 9.6;
	color("blue")
	if(screws) {
		union() {
			cube(size=[w, d, h], center=false);
			for(i=[-1,1]) {
				translate([w/2+i*hole_d/2, d/2, 2.5]) rotate([90, 0, 0]) cylinder(h=3*d, r=1, center=true);
			}
		}
	}else{
		difference() {
			cube(size=[w, d, h], center=false);
			for(i=[-1,1]) {
				translate([w/2+i*hole_d/2, d/2, 2.5]) rotate([90, 0, 0]) cylinder(h=3*d, r=1, center=true);
			}
		}
	}
}