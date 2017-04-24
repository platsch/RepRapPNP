/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de>
Maintainer: Florens Wasserfall <wasserfall@kalanka.de>
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html'
*******************************************************/

$fn=50;
servo_width=23;
servo_height=12.5;
servo_mount_width=27.5;
servo_mount_height=0;
servo_mount_dia=3;
thick=4;
servo_clearance=1.5;

servo_mount();

module servo_mount() {
    translate([0,(servo_height+0.4)/2+20/2,0])difference(){
        translate([0,-15/2+servo_clearance/2,0])cube([max(19+servo_mount_dia*3,servo_mount_width+servo_mount_dia*3),servo_height+0.4+15+servo_clearance,thick],center=true);
        for(i=[-1,1]){
            for(j=[-1,1]){
                translate([i*servo_mount_width/2,j*servo_mount_height+servo_clearance,0])cylinder(h=thick*2,d=servo_mount_dia,center=true);
            }
        }
        for(i=[-1,1]){
            translate([i*10,-(servo_height+0.4+15)/2,0]){
                cylinder(h=thick*2,d=3.5,center=true);
                translate([0,0,(thick-2)/2])cylinder(h=2.2, r=6/2, center=true);
            }
        }
        #translate([0,servo_clearance,0])cube([servo_width+0.4,servo_height+0.4,30],center=true);
    }
}
