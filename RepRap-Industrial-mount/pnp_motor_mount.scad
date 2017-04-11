/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de>
Maintainer: Florens Wasserfall <wasserfall@kalanka.de>
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html'
*******************************************************/

$fn=50;

pnp_motor_mount(30);

module pnp_motor_mount() {
    wall = 3;
    translate([-((28.5+2*wall)/2),-((28.5+2*wall)/2)-3,-40/2]) {
        difference(){
            hull(){
                translate([0,28.5+wall,50-wall]) cube([28.5+2*wall,wall+6.2,wall]);
                translate([0,1,0])cube([28.5+2*wall,27.5+2*wall+6.2,wall]);
            }
            translate([wall,wall,wall/2])cube([28.5,28.5,50]);
            translate([(28.5+2*wall)/2,(28.5+2*wall)/2,0]){
                cylinder(100,r=22.7/2,center=true);
                for(i=[-1, 1]) {
                    for(j=[-1,1]) {
                        translate([23/2*j,23/2*i,0]) cylinder(100,r=1.45);
                    }
                }
            }
            //servo mount
            translate([(28.5+2*wall)/2-8,28.5+5*wall,47])rotate([90,0,0])cylinder(h=wall*10, r=3/2, center=true);
            //robotdig
            for(i=[-1,1]){
            	for(j=[-1,1]){
	            	translate([(28.5+2*wall)/2+j*7.5,28.5+5*wall,30.5+i*5])rotate([90,0,0])cylinder(h=wall*10, r=3.3/2, center=true);
	            	translate([(28.5+2*wall)/2+j*7.5,28.5+4,30.5+i*5])rotate([90,0,0])cylinder(h=2, r=6/2, center=true);
	            }
	        }
            //igus
            for(i=[-1,1]){
                //translate([(28.5+2*wall)/2,28.5+2*wall,30.5+i*10])rotate([90,0,0])cylinder(h=wall*3, r=4.4/2, center=true);
                translate([(28.5+2*wall)/2,28.5+1+4,30.5+i*10])rotate([90,0,0])cylinder(h=4, r=12.5/2, center=true);
                translate([(28.5+2*wall)/2,28.5+0.40+wall+6.2,30.5+i*10])rotate([90,0,0])cylinder(h=5.25, r=6.4/2, center=true);
            }
        }
    }
}
