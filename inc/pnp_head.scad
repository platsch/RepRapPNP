/********************************************************
This file is part of the RepRapPNP project, developed at the University of Hamburg.
Author: Daniel Ahlers <2ahlers@informatik.uni-hamburg.de> 
License: 'GNU Affero General Public License AGPLv3 http://www.gnu.org/licenses/agpl.html' 
*******************************************************/

// general object resolution
$fn = 50;

module pnp_head(){
    rotate([180,0,0]){
        translate([0,0,-40.5]) {
            include <tube_adapter.scad>;
        }
        include <nema11_hollow.scad>
        translate([0,0,33]) {
            include <pnp_nozzle.scad>;
        }
    }
}