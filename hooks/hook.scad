use <lib.scad>;

module hook(clamp, hookRadius, frontSide) {
  $fn=100;
  h=10;
  width=4;


  cylinder(d=width, h=h);
  /**
   * backside of clamp, going down a bit
   */
  backSide = 20;
  translate([0, -backSide/2, h/2]) cube([width,backSide,h], center=true);


  /* clamp=24.2; */
  // upper part of the clamp
  translate([(clamp+width)/2, 0, h/2]) cube([clamp+width,width,h], center=true);

  // frontside of the clamp
  translate([clamp+width, 0, 0]) cylinder(d=width, h=h);
  /* frontSide = 25; */
  translate([clamp+width, -frontSide/2, h/2]) cube([width,frontSide,h], center=true);

  /* hookRadius = 20; */

  translate([clamp+width, -frontSide, 0])
    round_hanger(hookRadius, width, h);
}

hook(14.4, 12, 25);
