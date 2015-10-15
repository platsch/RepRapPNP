/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

include <../inc/nema.scad>
use <../inc/transmission_gears.scad>

// environment
//vacuum pipette
//#translate([25, 0, 0]) cylinder(r=5, h=100, center=true);
//translate([-25, 0, 17]) rotate([0, 0, 0]) transmission_gears(axis_dist=50, h=10, hub=6);

// render object
//vacuum_nema_mount();

module vacuum_nema_mount(height = 9) {
	difference() {
		hull() {
			cube(size=[nema_11_xy+6, nema_11_xy+6, height], center=true);
			translate([25, 0, 0]) cylinder(r=17, h=height, center=true);
		}
		translate([0, 0, 1]) scale(1.01) nema11(screw_length=4, screw_heads=true);

		//ball bearing
		translate([25, 0, -2]) {
			cylinder(r=19/2+0.1, h=7, center=false);
			cylinder(r=5.5, h=100, center=true);
		}
	}
}
/*
module vacuum_mount() {
	//#translate([0, 0, -16]) pipette();
	translate([0, -25, 74]) rotate([0, 0, 90]) rotate([0, 0, 0]) transmission_gears(axis_dist=50, h=10, hub=6);

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
*/