// Smoooooooth
$fn = 50;

use <parametric_involute_gear_v5.0.scad>


transmission_gears(axis_dist = 50);

module transmission_gears(axis_dist=60, h=7, hub=10, assembled=true) {
	if(assembled) {
		double_helix_gear(pitch_diameter=axis_dist/2, rim_thickness = h, rim_width=0, gear_thickness = h, hub_thickness = h+hub, hub_diameter=axis_dist/2+3, bore_diameter=10.4, circles=0);
		translate([axis_dist/2, 0, 0]) rotate([0, 0, 360/15]) rotate([180, 0, 0]) double_helix_gear(pitch_diameter=axis_dist/2, rim_thickness = h-2, rim_width=0, gear_thickness = h, hub_thickness = h+hub, hub_diameter=axis_dist/2-4, bore_diameter=5.4, circles=0);
		translate([axis_dist, 0, 0]) double_helix_gear(pitch_diameter=axis_dist/2, rim_thickness = h, rim_width=0, gear_thickness = h, hub_thickness = h+hub, hub_diameter=axis_dist/2+3, bore_diameter=10.4, circles=0);
	}else{
		rotate([180, 0, 0]) {
			double_helix_gear(pitch_diameter=axis_dist/2, rim_thickness = h, rim_width=0, gear_thickness = h, hub_thickness = h+hub, hub_diameter=axis_dist/2+3, bore_diameter=10.4, circles=0);
			translate([axis_dist/1.5, 0, h/2+2]) rotate([0, 180, 0]) double_helix_gear(pitch_diameter=axis_dist/2, rim_thickness = h-2, rim_width=0, gear_thickness = h, hub_thickness = h+hub, hub_diameter=axis_dist/2-4, bore_diameter=5.4, circles=0);
			translate([2*(axis_dist/1.5), 0, 0]) double_helix_gear(pitch_diameter=axis_dist/2, rim_thickness = h, rim_width=0, gear_thickness = h, hub_thickness = h+hub, hub_diameter=axis_dist/2+3, bore_diameter=10.4, circles=0);
		}
	}
}

//pi=3.1415926535897932384626433832795;
//#cylinder(r=(12.5), h=15, center=true);
//#translate([25, 0, 0]) cylinder(r=(12.5), h=15, center=true);

module double_helix_gear(
			pitch_diameter=10,
			number_of_teeth=15,
			//circular_pitch=450,
			//pressure_angle=10,
			clearance = 0.4,
			gear_thickness = 10,
			rim_thickness = 12,
			rim_width = 5,
			hub_thickness = 15,
			hub_diameter=13,
			bore_diameter=8,
			circles=8,
			twist=8) {
	circular_pitch = pitch_diameter/number_of_teeth*180;

	difference() {
		union() {
			gear(number_of_teeth=number_of_teeth,
				circular_pitch=circular_pitch,
				//pressure_angle=10,
				clearance = clearance,
				gear_thickness = gear_thickness/2,
				rim_thickness = rim_thickness/2,
				rim_width = rim_width,
				hub_thickness = hub_thickness-rim_thickness/2,
				hub_diameter=hub_diameter,
				bore_diameter=bore_diameter,
				circles=circles,
				twist=twist
			);

			mirror([0,0,1])
			gear(number_of_teeth=number_of_teeth,
				circular_pitch=circular_pitch,
				//pressure_angle=10,
				clearance = clearance,
				gear_thickness = rim_thickness/2,
				rim_thickness = rim_thickness/2,
				rim_width = rim_width,
				hub_thickness = rim_thickness/2,
				hub_diameter=hub_diameter,
				bore_diameter=bore_diameter,
				circles=circles,
				twist=twist
			);
		}
		//screw
		for(n=[0, 180]) {
			rotate([0, 0, n]) {
				translate([0, pitch_diameter/4+2, hub_thickness/2]) rotate([90, 0, 0]) cylinder(r=1.8, h=pitch_diameter/2+4, center=true);
				for(i=[0:1:2]) {
					translate([0, bore_diameter/2+(hub_diameter/2-bore_diameter/2)/2-0.5, hub_thickness/2+i*3]) rotate([90, 0, 0]) rotate([0, 0, 30]) cylinder(r=3.5, h=3.5, center=true, $fn=6);
				}
			}
		}
		
	}
}