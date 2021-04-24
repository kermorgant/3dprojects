use <lib.scad>;

$fn=100;
h=15;
width=6;

module suspended_hook(top, gape, hookRadius, width, h){
  cylinder(d=width, h=h);

  // upper part of the top
  translate([(top)/2, 0, h/2]) cube([top,width,h], center=true);

  // frontside of the top
  backSide = 30;
  translate([0, -backSide/2, h/2]) cube([width,backSide,h], center=true);

  translate([0, -backSide, 0])
    flat_hanger(hookRadius, width, h, gape);
}


gape=25;
top=11;
hookRadius = 8;

difference() {
  suspended_hook(top, gape, hookRadius, width, h);
  translate([(top)/2+1.5, 0, h/2])rotate([90,0,0]) cylinder(d=4, h=10, center=true);

  translate([(top)/2+1.5, 0.4, h/2]) rotate([90, 0, 0]) cylinder(d1=4, d2=8, h=3, center=false);
}
