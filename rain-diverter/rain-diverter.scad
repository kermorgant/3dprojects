use <threadlib/threadlib.scad>

$fn=120;
h=50;
width=4;

bottomJunctionHeight=10;

module escape() {
  // Thread peak radius reduction in mm (adjust this to your printer precision)
  corrector = 0.15; // [0:0.01:0.5]
  upper_thread = "G1/2";
  // Number of full thread turns
  upper_turns = 7; // [1:1:20]
  // Wall Thickness
  upper_wall = 1.2; // [0.5:0.1:10]
  // Create a chamfer for the upper thread
  upper_chamfer = true;

  specs = thread_specs(str(upper_thread, "-int"));


  diam = specs[2];

  thickness = 3;
  length=10;
  translate([0,0,diam/2])
  rotate([0,90,0])
    difference() {
    cylinder(d=diam, h=length, center=true);
    cylinder(d=diam - 2*thickness, h=length+2, center=true);
  }
}

module escapeHole() {
  thickness = 3;
  diam = 21;
  length=20;
  translate([0,0,diam/2])
    rotate([0,90,0])
    cylinder(d=diam -2 * thickness, h=length, center=true);
}

module mainPipe(pipeInnerDiameter){
  innerTopWidth=pipeInnerDiameter;
  outerBottomWidth=pipeInnerDiameter-1;
  lateralGutterWidth=10;
  difference() {
    union() {
      translate([0,0,h/2])
        cylinder(d1=outerBottomWidth, d2=innerTopWidth+width, h=h, center=true);
      translate([pipeInnerDiameter/2-2, 0, bottomJunctionHeight]) escape();
    }
    translate([0,0,h/2]) cylinder(d1=outerBottomWidth-width, d2=innerTopWidth, h=h+2, center=true);

  }
}

module radialGutter(outerDiameter, gutterWidth) {
  gutterThickness = 4;
  gutterWallHeight = 18;
  gutterWallWidth = 4;
  translate([0,0,gutterThickness/2])
    difference() {
    cylinder(d=outerDiameter, h=gutterThickness, center=true);
    cylinder(d=outerDiameter-gutterWidth, h=gutterThickness+2, center=true);
  }

  translate([0,0,gutterWallHeight/2])
    difference() {
    cylinder(d=outerDiameter-gutterWidth, h=gutterWallHeight, center=true);
    cylinder(d=outerDiameter-(gutterWidth+gutterWallWidth), h=gutterWallHeight+2, center=true);
  }
}
pipeInnerDiameter=86;

difference() {
  mainPipe(pipeInnerDiameter);
  translate([pipeInnerDiameter/2, 0, bottomJunctionHeight]) escapeHole();
}

/* translate([pipeInnerDiameter/2+width, 0, 0]) escape(); */

radialGutter(pipeInnerDiameter-width, 10);



/* /\** */
/*  * backside of clamp, going down a bit */
/*  *\/ */
/* backSide = 25; */
/* translate([0, -backSide/2, h/2]) cube([width,backSide,h], center=true); */


/* clamp=25; */
/* // upper part of the clamp */
/* translate([(clamp+width)/2, 0, h/2]) cube([clamp+width,width,h], center=true); */

/* // frontside of the clamp */
/* translate([clamp+width, 0, 0]) cylinder(d=width, h=h); */
/* frontSide = 11; */
/* translate([clamp+width, -frontSide/2, h/2]) cube([width,frontSide,h], center=true); */

/* hookDepth = 12; */


/* difference() { */
/*   translate([clamp+width/2,-frontSide-hookDepth,0]) cube(size=[(hookDepth+width)*2, hookDepth,h]); */
/*   translate([clamp+width+width/2,-frontSide-hookDepth+width,-1]) cube(size=[(hookDepth)*2, hookDepth, h+2]); */
/* } */

/* translate([clamp+width+hookDepth+width, -frontSide-hookDepth+width, 0]) cube(size=[width, 1.5*width, h], center=false); */

/* translate([clamp+width+2*hookDepth+width, -frontSide, 0]) cylinder(d=width, h=h, center=false); */
