use <threadlib/threadlib.scad>

// origin : https://www.thingiverse.com/thing:4323468/files
module create_external_threaded_part(upper_part=true, thread="M10", turns=1, min_wall_size=1.0, chamfer=true, corrector=0.00) {

  specs = thread_specs(str(thread, "-ext"));
  P = specs[0]; Rrot = specs[1]; Dsupport = specs[2];
  section_profile = specs[3];
  H = (turns+1)*P;
  TH = section_profile[3][0];
  Douter=(Rrot+TH-corrector)*2;

  //Set chamfer size to thread height if ther is a chamfer to be created
  chamfer_size = chamfer ? TH : 0;

  difference()
    {
      difference()
        {
          //Create core and resized thread
          union()
          {
            cylinder(h=H, r=Dsupport/2); //core
            translate([0,0,P*0.5])
              resize([Douter, Douter, 0])
              thread(str(thread,"-ext"),turns=turns);
          }

          //Subtract chamfer
          if (upper_part){
            translate([0,0,H-chamfer_size*2+0.01])
              difference(){
              cylinder(h=chamfer_size*3+0.02, d=Douter+0.02, center=false);
              cylinder(h=chamfer_size*3+0.02, r1=Dsupport/2+chamfer_size, r2=Dsupport/2-chamfer_size*2, center=false);
            }
          }
          else{
            translate([0,0,-0.01])
              difference(){
              cylinder(h=chamfer_size*3+0.02, d=Douter+2, center=false);
              cylinder(h=chamfer_size*3+0.02, r1=Dsupport/2-chamfer_size*2, r2=Dsupport/2+chamfer_size, center=false);
            }
          }
        }
      //Subtract inner channel
      translate([0,0,-0.01]) cylinder(h=H+0.02, r=(Dsupport/2-min_wall_size)*fudge);
    }
}

$fn=120;
h=50;
width=4;

/* imported block */
//correction factor for circle subtraction to avoid undersized holes
fudge = 1/cos(180/$fn);

/* end of import */
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
  translate([0,0,diam/2])
    rotate([0,90,0])
    create_external_threaded_part(
                                  upper_part=true,
                                  thread=upper_thread,
                                  turns=upper_turns,
                                  min_wall_size=upper_wall,
                                  chamfer=upper_chamfer,
                                  corrector=corrector);

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
  /* escape(); */
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