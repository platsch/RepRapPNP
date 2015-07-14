// Smoooooooth
$fn = 50;

heat_block(tip="luer");

module heat_block(w=15, h=25, luer_offset=-3.5, tip="luer") {
	//translate([luer_offset, axis_offset+syringe_axis_offset-abs(luer_offset), -108]) {
	difference() {
		union() {
			//base block
			translate([0, 0, -h/2]) cube(size=[w, w, h], center=true);
			//mount screw
			translate([0, -luer_offset, -15]) rotate([0, 90, 0]) cylinder(r=2.5, h=40, center=true);
		}
		//heater cartridge
		translate([3.5, 0, -9]) rotate([90, 0, 0]) cylinder(r=3, h=w+1, center=true);
		translate([3.5, 2, -4]) cylinder(r=1.5, h=10, center=true);

		//thermistor
		translate([-3.5, w/2-2.49, -5]) rotate([90, 0, 0]) cylinder(r=1.25, h=5, center=true);
		translate([-3.5, w/2-4, -5]) cylinder(r=1.25, h=5.5, center=false);

		//luer tip
		if(tip=="luer") {
			translate([luer_offset, luer_offset, -6+0.01]) cylinder(r=3, h=6, center=false);
			translate([luer_offset, luer_offset, -9-6+0.02]) cylinder(r=2.5, h=9, center=false);
			translate([luer_offset, luer_offset, -h-0.5])cylinder(r=0.5, h=h+1, center=false);
		}
		if(tip=="luer_lock") {
			//translate([luer_offset, luer_offset, -5+h/2+0.01]) cylinder(r=5, h=10, center=true);
		}
	}
		//translate([0, -4, -5]) rotate([0, 90, 0]) cylinder(r=2.7, h=40, center=true);	
}