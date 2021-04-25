use <lib.scad>;

$fn=100;
h=15;
width=6;

module basic_hook(backHeight, hookRadius, width, h){
  translate([-width/4, 0, h/2]) cube([width/2, width, h], center=true);
  cylinder(d=width, h=h);

  // frontside of the top
  difference() {
    translate([0, -backHeight/2, h/2]) cube([width,backHeight,h], center=true);
    translate([0, -8, h/2])rotate([0,90,0]) cylinder(d=4, h=10, center=true);
    translate([0, -8, h/2]) rotate([0, 90, 0]) cylinder(d1=4, d2=8, h=3, center=false);
}


  translate([-width/2, -backHeight, 0])
    round_hanger(hookRadius, width, h);
}


top=30;
hookRadius = 20;

// 1.0
/* basic_hook(30, 20, 6, 15); */

// 1.1
basic_hook(30, 10, 4, 15);
