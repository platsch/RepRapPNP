/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de>
Maintainer: Florens Wasserfall <wasserfall@kalanka.de>
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html'
*******************************************************/

thickness=3;
$fn=50;

//Syringe
//servo_connector(3.5,2.5,35,0,0);
//PNP
servo_connector(3.5,2.5,57.5,0,0);

// parameters hole diameter1, hole diameter2, distance, hole1 clearance, hole2 clearance
module servo_connector(h1_dia, h2_dia, distance, h1_clear, h2_clear){
  difference() {
    union() {
      hull() {
        translate([distance/2,0,0])cylinder(r=4, h=thickness, center=true);
        translate([-distance/2,0,0])cylinder(r=4, h=thickness, center=true);
      }
      translate([distance/2,0,-thickness/2-h1_clear/2])cylinder(r=4, h=h1_clear, center=true);
      translate([-distance/2,0,-thickness/2-h2_clear/2])cylinder(r=4, h=h2_clear, center=true);
    }
    translate([distance/2, 0, -h1_clear])cylinder(d=h1_dia, h=thickness, center=true);
    translate([distance/2, 0, +thickness/2-h1_clear/2])cylinder(d=5.5, h=h1_clear, center=true);
    translate([-distance/2, 0, -h2_clear])cylinder(d=h2_dia, h=thickness, center=true);
    translate([-distance/2, 0, +thickness/2-h2_clear/2 ])cylinder(d=5.5, h=h2_clear, center=true);
  }

}
