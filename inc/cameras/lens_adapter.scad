// general object resolution
$fn = 200;

dia_in = 25.2;
dia_out = 30.0;
thickness = 1.3;

difference() {
	cylinder(r=dia_out/2, h=thickness, center=true);
	cylinder(r=dia_in/2, h=10, center=true);
}