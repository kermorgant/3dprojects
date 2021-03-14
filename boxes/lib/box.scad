use <../../mcad/boxes.scad>;

module grip() {
  translate([-5,0,0])
    rotate([-90,0,0])
    intersection() {
    cube([10, 5, 15], center=false);
    rotate([40,0,0])cube([20, 5, 15], center=true);
  }
}

module box(width, length, height) {
  walls = 3;
  difference() {
    roundedCube([width, length, height], 2, true, true);
    translate([0,0,2])roundedCube([width-walls, length-walls, height-walls], 2, true, true);
  }

  translate([0,-length/2,height/2]) grip();
}

module box11(width, height) {
  box(width, width, height);
}

module box12(width, height) {
  box(width, 2*width, height);
}

module box14(width, height) {
  box(width, 4*width, height);
}
