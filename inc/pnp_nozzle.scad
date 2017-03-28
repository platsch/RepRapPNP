/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

cylinder(22,r=14/2,center=true);
translate([0,0,22/2+5.5/2])  {
    cylinder(5.5,r=10/2,center=true);
    translate([0,0,5.5/2+1.5/2]) cylinder(1.5,r=16/2,center=true);
    translate([0,0,5.5/2+1.5/2+4.5/2]) cylinder(4.5,r=12/2,center=true);
    translate([0,0,5.5/2+1.5/2+4.5/2+12.5/2]) cylinder(12.5,r=5/2,center=true);
}