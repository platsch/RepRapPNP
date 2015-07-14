// ********** CHANGE THESE PARAMETERS TO ADAPT DIMENSIONS ********** //

// OUTER DIAMETER
D1 = 21.0;

// INNER DIAMETER TOP
DT2 = 5.3;

// INNER DIAMETER BOTTOM
DB2 = 5.3;

//INNER DIAMETER SPRINGS
DS = 9.0;

// TOTAL HEIGHT
H1 = 35;

// BASE HEIGHT TOP
HT2 = 8;

// BASE HEIGHT BOTTOM
HB2 = 9;

// NUMBER OF FLEXIBLE ELEMENTS
N  = 10;

// SCREW HOLE DIAMETER
D3 = 3.5;

// NUT HOLE DIAMETER
Dnut=6.8;

// NUT HOLE THICKNESS
Hnut=2.6;

// FLAT SHAFT THICKNESS
B=6.5;

// SCREW HOLE DISTANCE
H3=4;

// SPRINGS RESOLUTION
SLICES=16; //[6:36]

// ********** DON'T CHANGE BELOW UNLESS YOU KNOW WHAT TO DO ********** //

Re = D1/2;	// outer radius
RBi = DB2/2;	// inner radius
RTi = DT2/2;	// inner radius
fn = 4*N;	// default face number for cylinders
R3 = D3/2;	// screw hole radius
Rnut=Dnut/2;	// nut hole radius
B2 = B-RBi;	// flat face distance from center
Hspring=H1-HT2-HB2;

flexible_coupling();

module sq_spring(in_R,out_R,height,rot) {
	width=out_R-in_R;
	linear_extrude(height = height, center = false, convexity = 50, twist = rot, slices = SLICES)
	polygon(points=[[in_R,0],
			[out_R,0],
			[out_R*cos(180/N),out_R*sin(180/N)],
			[in_R*cos(180/N),in_R*sin(180/N)]],
			paths=[[0,1,2,3]]);
}

module hole_h(HoleDist) {
	rotate([0,90,0]) {
		translate ([-HoleDist,0,(Re+B2)/2]) cylinder(r=R3,h=Re*1.2,center=true,$fn=fn);
		translate([-HoleDist,0,(Re+B2)/2.5]) cylinder(r=Rnut,h=Hnut,center=true,$fn=6);
		translate([0,0,(Re+B2)/2.5]) cube(size=[2*HoleDist,2*Rnut*cos(30),Hnut],center=true);
	}
}


$fn=fn;
module body(height, Re, Ri) {
	difference() {
		union() {
			difference(){
				cylinder (r=Re,h=height,center=false, $fn=fn);
				cylinder(r=Ri,h=height,center=false, $fn=fn);
				}
			//translate([B2,-Ri,0]) cube(size=[Ri,2*Ri,height], center=false);
		}
		hole_h(H3);
	}
}


module flexible_coupling() {
	body(HB2, Re, RBi);
	translate([0,0,H1]) rotate([0,180,0]) body(HT2, Re, RTi);
	for (i=[1:N]){
		rotate([0,0,360*i/N]) translate ([0,0,HB2]) sq_spring(DS/2,Re,Hspring,120);
	}
}
