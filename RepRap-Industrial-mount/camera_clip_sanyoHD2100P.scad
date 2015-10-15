/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

$fn=50;

// render
rotate([0, 90, 0]) camera_clip();

module camera_clip() {
    thickness = 8;
	difference() {
		// mount screws for printer
		translate([0, 0, 19]) cube(size=[thickness, 96, 38], center=true);
		for(i=[-1,1]){
			for(k=[-1, 1]) {
				translate([0, i*43, 15+k*7.5]) rotate([0, 90, 0]) cylinder(r=1.8, h=20, center=true);
			}
		}

		// space for camera
		translate([-thickness/2, 0, 19]) cube(size=[3, 80, 40], center=true);

		//mount screws for camera
		for(i=[-1, 1]) {
			hull() {
				for(k=[0, 1]) { 
		   			translate([0, i*(28/2), 8+k*21]) rotate([0, 90, 0]) cylinder(r=1.8, h=20, center=true);
		   		}
		   	}
		}
	}
}