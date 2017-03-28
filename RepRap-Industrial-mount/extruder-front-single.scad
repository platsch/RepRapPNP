/*******************************************************************

This OpenSCAD code and its rendered 3D model are part of the

	Kühling&Kühling RepRap Industrial 3D Printer


All details, BOM, assembling instructions and latest sources:
	http://kuehlingkuehling.de

Designed and developed by:
	Jonas Kühling <mail@jonaskuehling.de>
	Simon Kühling <mail@simonkuehling.de>

Modified by:
	Daniel Ahlers <2ahlers@informatik.uni-hamburg.de>

License:
	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
	https://creativecommons.org/licenses/by-sa/4.0/

*******************************************************************/

include <RepRap-Industrial/configuration.scad>
use <RepRap-Industrial/extruder-front.scad>



// RENDER EXTRUDER
rotate([90,0,0]) extruder_front_single();


module extruder_front_single(){
	difference(){
		union(){
			translate([extruder_front_body_width/2,0,0])
				extruder_front();
			translate([-extruder_front_body_width/2,0,0]) mirror([1,0,0]) extruder_front();
		}
		translate([-60-extruder_mount_screw_washer_dia/2,-40,-30])cube(size=[60,60,60], center=false);
	}
}