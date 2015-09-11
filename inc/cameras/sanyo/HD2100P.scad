/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

// render camera
//HD2100P();

module HD2100P() {
	edge_r=5;
	h=85;

	translate([0, 0, h/2]) {
		difference() {
		    hull() {
		        for(i=[-1,1]) {
		            for(j=[-1,1]) {
		                translate([i*(72/2-edge_r), j*(45/2-edge_r), 0]) cylinder(r=edge_r, h=85, center=true);
		            }
		        }
		    }
		    //mount screws
		    for(i=[-1, 1]) {
		    	translate([i*(28/2), 45/2+1, -h/2+20]) rotate([90, 0, 0]) cylinder(r=1.5, h=10, center=false);
		    }

		    //CS mount
		    translate([0, 0, -h/2]) cylinder(r=25.4/2, h=10, center=true);
		}
	}
}