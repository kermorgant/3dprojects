module round1_4(radius, width, height) {
  translate([0,radius-width/2,0])
  rotate([0, 0, -90])
  intersection() {
    difference() {
      cylinder(r=radius, h=height, center=false);
      translate([0,0,-1])cylinder(r=radius-width, h=height+2, center=false);
    }
    cube(size=radius*2);
  }
}

module round1_8(radius, width) {
  difference() {
  round1_4(radius, width);
  translate([0, radius, -1]) rotate([0, 0, -45]) cube([radius, radius, width + 2]);
  }
}

module flat_hanger(hookRadius, width, h, clamp) {
  rotate([0, 0, -90]) round1_4(hookRadius, width, h);

  translate([hookRadius-width/2+clamp/2, width/2-hookRadius, h/2])
    cube([clamp, width, h], center=true);

  translate([clamp+hookRadius/2, width/2-hookRadius, 0])
    rotate([0, 0, 0]) round1_4(hookRadius, width, h);

  translate([clamp+1.5*width, 0, 0])
    cylinder(d=width, h=h, center=false);

}

module round_hanger(hookRadius, width, h) {
  difference() {
    difference() {
      translate([(hookRadius-width/2),0,0]) cylinder(r=hookRadius, h=h);
      translate([(hookRadius-width/2),0,0]) cylinder(r=hookRadius-width, h=2*h+2, center=true);
    }

    translate([0, 0, -1]) cube([2*hookRadius, hookRadius+2, h+2], center=false);
  }


  translate([2*hookRadius-width, 0, 0])
    cylinder(d=width, h=h, center=false);
}