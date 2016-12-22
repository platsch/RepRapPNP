/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Daniel Ahlers <Danielahlers@googlemail.com> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

// mount visualization
use <led_ring_mount.scad>;
translate([0,0,-25.5-1.6*3]){
    %camera_mount(2,1.6);
}
%translate([0,0,5.4]) rotate([180, 0, 0])  {
    include <../cameras/basler/lens_cover_ring.scad>;
}

module led_ring(t,r1,r2){
    translate([0,0,t/2]){
        difference(){
            union(){
                cylinder(h=t, r=r2, center=true);
                translate([0,-24.5+3,0]) cube([28+10,16,t],center=true);
            }
            for(i=[-1, 1]) {
                    translate([i*(28/2), -24.5, 0]) cylinder(r=1.6, h=t+1, center=true);
            }
            for(i=[-1, 1]) {
                rotate([0,0,30]) translate([i*(r1+(r2-r1)/2), 0, 0]) cylinder(r=1.6, h=t+1, center=true);
            }
            cylinder(h=t+1, r=r1, center=true);
            translate([0,23+5, 0]) cube([r2*2,10,t+1], center=true);
        }
    }
}

led_ring(3,16,16+8);