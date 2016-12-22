/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Daniel Ahlers <Danielahlers@googlemail.com> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

// camera visualization
//include <sanyo/HD2100P.scad>;
//%rotate([180,0,0]) HD2100P();
//%translate([0, 0, 2.5]) {
//    include <lens_adapter.scad>;
//}
//%rotate([0, 90, 0]) translate([-5, 0, 0])import("basler/Basler Lens 8mm C-Mount v02.stl");
//%translate([0,0,33+2.7]) rotate([180, 0, 0])  {
//    include <basler/lens_cover_ring.scad>;
//}



module camera_mount(t,r_h){
    translate([0,-45/2, 25.5]) {
        difference() {
            union(){
                hull() {
                    for(i=[-1, 1]) {
                        translate([i*(28/2), -t/2, -30.5+5]) rotate([90, 0, 0]) cylinder(r=5, h=t, center=true);
                        translate([i*(28/2), -t/2, 0]) rotate([90, 0, 0]) cube([10,10, t], center=true);
                    }
                }
                hull() {
                    translate([0, -t-(8-t)/2, -5+1.5]) cube([28+10,8-t,17], center=true);
                    translate([0,-t/2,-11]) cube([28+10,t,1], center=true);
                }
            }   
            translate([0, -t/2, -12.8]) rotate([90, 0, 0]) cube([18,15.5,t+30], center=true);
              for(i=[-1, 1]) {
                  translate([i*(26/2), 0, -30.5+5]) rotate([90, 0, 0]) cylinder(r=r_h, h=t*3, center=true);
              }
              for(i=[-1, 1]) {
                  translate([i*(28/2), -4.5, 5-8]) cylinder(r=r_h, h=16.1, center=true);
              }
              for(i=[-1, 1]) {
                  for(j=[0,2,t+2]) {
                  translate([i*(28/2), -4.5+j, 5-1.5-8]) rotate([0, 0, 90]) cylinder(r=3.3,h=3,$fn =6, center=true);
                  }
              }
        }
   }
}

camera_mount(3,1.6);
