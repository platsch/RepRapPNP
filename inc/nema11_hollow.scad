/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

cube([28.2,28.2,34], center=true);
translate([0,0,34/2+2/2]) cylinder(2,r=22/2,center=true);
translate([0,0,34/2+9/2]) cylinder(9,r=5/2,center=true);
translate([0,0,-34/2-7/2]) cylinder(7,r=8/2,center=true);