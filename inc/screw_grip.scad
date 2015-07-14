include<mcad/regular_shapes.scad>

$fs=0.2; // def 1, 0.2 is high res
$fa=3;//def 12, 3 is very nice

//M3
// screw_dia = 3.5;
// nut_dia = 6.4;
// nut_height = 2.5;

//M4
/*screw_dia = 4.2;
nut_dia = 8.2;
nut_height = 4;
*/

//M5
screw_dia = 5.4;
nut_dia=9.5;
nut_height = 4;

//M8
/*screw_dia = 8.2;
nut_dia = 15;
nut_height = 6;
*/

dia = screw_dia*4;
//base_height=nut_height;
base_height=0;

difference() {
	union() {
		cylinder(r1=screw_dia, r2=dia/2, h=base_height, center=false);
		translate([0, 0, base_height]) cylinder(r=dia/2, h=nut_height, center=false);
	}
	translate([0, 0, base_height+0.2]) screw(screw_dia, 30, nut_dia, nut_height);

	for(i=[1:360/20]) {
			rotate([0, 0, i*20]) translate([dia/2+1,0,0]) cylinder(h=50, r=2, center=true);
		}
}


module screw(screw_dia, length, nut_dia, nut_height) {
	translate([0, 0, -length/2]) {
		union() {
			//body
			cylinder(r=screw_dia/2, h=length, center=true);
			//nut
			translate([0, 0, length/2+nut_height/2-0.01]) {
				cylinder(r=nut_dia/2, h=nut_height, $fn=6, center=true);
			}
		}
	}
}