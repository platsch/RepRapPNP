

// Smoooooooth
$fn = 50;

ring_height = 2.5;
ring_dia_out = 48;
ring_dia_in = 36;
screw_offset = sqrt(16*16+16*16);
circuit_height = 0.25;
circuit_width = 0.8;

//led_ring_base();
translate([0, 0, ring_height]) led_ring_circuit();
//led_smd_7262();

module led_ring_base() {
	difference() {
		union() {
			cylinder(r=ring_dia_out/2, h=ring_height, center=false);
			for(k=[-1, 1]) {
				translate([k*screw_offset, 0, 0]) cylinder(r=4.5, h=ring_height, center=false);
			}
		}
		//center
		cylinder(r=ring_dia_in/2, h=ring_height*2+1, center=true);
		//mount screws
		for(k=[-1,1]) {
			translate([k*screw_offset, 0, 0]) cylinder(r=1.7, h=20, center=true);
		}
	}
}

module led_ring_circuit() {
	difference() {
		union() {
			//led bodys
			for(i=[0:5]) {
				%rotate([0, 0, 60*i+30]) translate([(ring_dia_in+ring_dia_out)/4, 0, 0]) led_smd_7262();
			}
			//main wire
			difference() {
				cylinder(r=(ring_dia_out+ring_dia_in)/4+circuit_width/2+0.5, h=circuit_height, center=false);
				cylinder(r=(ring_dia_out+ring_dia_in)/4-circuit_width/2+0.5, h=3*circuit_height, center=true);
			}
			//screw connectors
			for(i=[-1, 1]) {
				translate([i*screw_offset, 0, 0]) cylinder(r=4, h=circuit_height, center=false);
			}
		}
		//mount screws
		for(i=[-1, 1]) {
			translate([i*screw_offset, 0, 0]) {
				difference() cylinder(r=1.7, h=3*circuit_height, center=true);
			}
		}
		//main wire interruptions
		for(i=[0:5]) {
			rotate([0, 0, 60*i+30]) translate([(ring_dia_in+ring_dia_out)/4, 0, 0]) cube(size=[10, 4, 10], center=true);
		}
	}
}

module led_smd_7262() {
	union() {
		//body
		translate([0, 0, 3.1/2]) cube(size=[6.2, 7.2, 3.1], center=true);
		//pads
		translate([0, 0, 0.5]) cube(size=[1.9, 11.2, 1], center=true);
	}
}