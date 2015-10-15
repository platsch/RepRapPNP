// general object resolution
$fn = 200;

dia_in = 26;
dia_out = 30.0;
thickness = 5.0;

difference() {
	cylinder(r=dia_out/2, h=thickness, center=true);
	cylinder(r=dia_in/2, h=10, center=true);
}