/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de>
Maintainer: Florens Wasserfall <wasserfall@kalanka.de>
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html'
*******************************************************/

$fn=50;

mechanical_stop(30);

module mechanical_stop(screw_length) {
    difference() {
    	t=10;
        cube([21,4+5,t]);
        translate([21/2,4,-1])cylinder(h=t+2,r=3/2);
        for(i=[-1,1]){
        	translate([21/2+i*13/2,3.5,t/2])rotate([90,0,0])cylinder(h=3.6, r=6/2, center=false);
        	translate([21/2+i*13/2,20,t/2])rotate([90,0,0])cylinder(h=40, r=3.5/2, center=false);
        }
        for(i=[0:6]) {
            translate([21/2, 4+i, t/2])rotate([0,0,90])cylinder(r=6.3/2, h=4, center=true, $fn=6);
        }

    }
    %translate([21/2,4,-4.3-5])cylinder(h=4.3,r=8.1/2);
    %translate([21/2,4,-5])cylinder(h=screw_length,r=3/2);
}
