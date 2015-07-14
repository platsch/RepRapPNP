// Smoooooooth
$fn = 50;


nema_xy = 42.0;
nema_11_xy = 28.5;


//nema11(10);

//nema 17 motor screws and shaft
module nema17(screw_length, screw_heads = false){
	color("Grey") union(){
		//screws
		for(r=[1:4]) {
			rotate([0,0,r*360/4]) translate([15.5,15.5,-1.91]) cylinder(screw_length,r=1.8, center=false);
			if (screw_heads) {
				rotate([0,0,r*360/4]) translate([15.5,15.5,-1.92+screw_length]) cylinder(screw_length*6,r=3.2, center=false);
			}
		}
		//body
		translate([0, 0, -26.905]) cube(size=[nema_xy, nema_xy, 50], center=true);
		translate([0, 0, -1.905]) cylinder(r=12.2, h=2.2, center=false);

		//shaft
		translate([0, 0, -0.01])cylinder(r=2.8, h=20, center=false);
	}
}

//nema 11 motor screws and shaft
module nema11(screw_length, screw_heads = false){
	color("Grey") union(){
		//screws
		for(r=[1:4]) {
			rotate([0,0,r*360/4]) translate([23/2,23/2,-1.91]) cylinder(screw_length,r=1.8, center=false);
			if (screw_heads) {
				rotate([0,0,r*360/4]) translate([23/2,23/2,-1.92+screw_length]) cylinder(screw_length*6,r=3.2, center=false);
			}
		}
		//body
		translate([0, 0, -26.905]) cube(size=[nema_11_xy, nema_11_xy, 50], center=true);
		translate([0, 0, -1.905]) cylinder(r=12.2, h=2.2, center=false);

		//shaft
		translate([0, 0, -0.01])cylinder(r=2.8, h=20, center=false);
	}
}