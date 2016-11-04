/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.

It heavily relies on the work by Jonas and Simon Kühling for the RepRap-Industrial design.

Author: Florens Wasserfall <wasserfall@kalanka.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/
$fn = 50;

// lens visualization
%rotate([0, -90, 0]) translate([33, 0, 0]) import("Basler Lens 8mm C-Mount v02.stl");

lens_outer_dia = 30;
h = 5.5;

difference() {
	cylinder(h=h, r=lens_outer_dia/2+4, center=false);
	translate([0, 0, 2.8]) cylinder(h=h, r=lens_outer_dia/2, center=false);
	cylinder(h=3*h, r=lens_outer_dia/2-2, center=true);
	// glas object plate 76 x 26 x 1mm
	translate([0, 0, 0.49]) cube(size=[76, 26.5, 1], center=true);
}