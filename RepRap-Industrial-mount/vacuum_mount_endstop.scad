/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/



module vacuum_mount_endstop(dia_out=20, dia_in=10, h=8) {
	difference() {
		cylinder(r=dia_out/2, h=h, center=true);
		cylinder(r=dia_in/2, h=h+1, center=true);
		//screw
		rotate([-90, 0, 0]) cylinder(r=1.7, h=dia_out, center=false);
		for(i = [0:2]) {
			translate([0, dia_in/2+2, i*2]) rotate([90, 0, 0]) rotate([0, 0, 30]) cylinder(r=3.4, h=3, center=true, $fn=6);
		}
	}
}