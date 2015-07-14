// Smoooooooth
$fn = 50;

//syringe(luer_lock=true);


//parameters for hamilton X041.1 syringe 1ml
syringe_piston_dia = 4.65;
syringe_cylinder_dia = 7.5;
syringe_piston_length = 98;
syringe_flange_dia = 13.1;
syringe_flange_height = 2.85;
syringe_piston_flange_dia = 13.0;
syringe_piston_flange_height = 3.3;
syringe_piston_offset = 13.2;
syringe_luer_lock=true;
syringe_luer_lock_length=13; 

module syringe(luer_lock=false) {
	_syringe(
		syringe_piston_dia = syringe_piston_dia,
		syringe_cylinder_dia = syringe_cylinder_dia,
		syringe_piston_length = syringe_piston_length,
		syringe_flange_dia = syringe_flange_dia,
		syringe_flange_height = syringe_flange_height,
		syringe_piston_flange_dia = syringe_piston_flange_dia,
		syringe_piston_flange_height = syringe_piston_flange_height,
		syringe_piston_offset = syringe_piston_offset,
		syringe_luer_lock=syringe_luer_lock);
}

module syringe_1ml(luer_lock=false) {
	_syringe(
		syringe_piston_dia = 4.65,
		syringe_cylinder_dia = 7.5,
		syringe_piston_length = 98,
		syringe_flange_dia = 13.1,
		syringe_flange_height = 2.9,
		syringe_piston_flange_dia = 13.0,
		syringe_piston_flange_height = 3.3,
		syringe_piston_offset = 8.2,
		syringe_luer_lock=syringe_luer_lock);
}

module syringe_2ml(luer_lock=false) {
	_syringe(
		syringe_piston_dia = 7.5,
		syringe_cylinder_dia = 11.8,
		syringe_piston_length = 63,
		syringe_flange_dia = 19,
		syringe_flange_height = 3,
		syringe_piston_flange_dia = 13.1,
		syringe_piston_flange_height = 4,
		syringe_piston_offset = 7,
		syringe_luer_lock=syringe_luer_lock);
}

module syringe_5ml() {
	_syringe(
		syringe_piston_dia = 10,
		syringe_cylinder_dia = 14.7,
		syringe_piston_length = 80.5,
		syringe_flange_dia = 21.8,
		syringe_flange_height = 3.5,
		syringe_piston_flange_dia = 15.8,
		syringe_piston_flange_height = 4,
		syringe_piston_offset = 8,
		syringe_luer_lock=syringe_luer_lock);
}

module _syringe(
	syringe_piston_dia = 8, 
	syringe_cylinder_dia = 15, 
	syringe_piston_length=60, 
	syringe_flange_dia = 20,
	syringe_flange_height = 2,
	syringe_piston_flange_dia = 10,
	syringe_piston_flange_height = 4,
	syringe_piston_offset = 7,
	syringe_luer_lock=false) {

	//syringes outer cylinder
	cylinder(r=syringe_cylinder_dia/2, h=syringe_piston_length-syringe_piston_offset, center=false);

	//flange
	translate([0, 0, syringe_piston_length-syringe_piston_offset-syringe_flange_height/2]) hull() {
		rotate_extrude(convexity = 10, $fn = 30)
		translate([syringe_flange_dia/2, 0, 0])
		circle(r = syringe_flange_height/2, $fn = 30);
	}

	//piston
	cylinder(r=syringe_piston_dia/2, h=syringe_piston_length, center=false);

	//piston flange
	translate([0, 0, syringe_piston_length+syringe_flange_height/2]) hull() {
		rotate_extrude(convexity = 10, $fn = 30)
		translate([syringe_piston_flange_dia/2, 0, 0])
		circle(r = syringe_piston_flange_height/2, $fn = 30);
	}

	//luer conus
	if(syringe_luer_lock) {
		syringe_luer_lock();
	}else{
		luer();
	}
}

module syringe_luer_lock() {
	union() {
		translate([0, 0, -syringe_luer_lock_length]) cylinder(r=5, h=syringe_luer_lock_length, center=false);
		translate([0, 0, -7.5]) luer();
	}
}

//luer conus used by standard medical syringes
module luer() {
	difference() {
		translate([0, 0, -8.5]) cylinder(r1=4.0/2, r2=4.3/2, h=8.5, center=false);
		cylinder(r=1.5/2, h=20, center=true);
	}
}