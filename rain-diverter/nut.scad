use <threadlib/threadlib.scad>

difference() {
  cylinder(h=5, d=28, $fn=6, center=false);
  tap("G1/2", turns=6);
}
