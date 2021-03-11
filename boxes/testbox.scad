use <../mcad/boxes.scad>;


$fn=100;

module grip() {
  translate([-5,0,0])
    rotate([-90,0,0])
    intersection() {
    cube([10, 5, 15], center=false);
    rotate([40,0,0])cube([20, 5, 15], center=true);
  }
}

module box(width, length, height) {
  difference() {
    roundedCube([width, length, height], 2, true, true);
    translate([0,0,2])roundedCube([width-2, length-2, height-2], 2, true, true);
  }

  translate([0,-length/2,height/2]) grip();
}

module box11(with, height) {
  box(width, width, height);
}

module box12(width, height) {
  box(width, 2*width, height);
}

module box14(width, height) {
  box(width, 4*width, height);
}


width = 20;
length = width * 4;
height = 30;

box14(width, height);
