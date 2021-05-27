use <threadlib/threadlib.scad>

turns = 7;
thread="G1/2-ext";

thread(thread, turns=turns);

specs = thread_specs(thread);

P = specs[0]; Rrot = specs[1]; Dsupport = specs[2];
section_profile = specs[3];
H = (turns + 1) * P;

difference() {
translate([0, 0, -P / 2])
    cylinder(h=H, d=Dsupport, $fn=120); /*  */
translate([0, 0, -P / 2 -1])
    cylinder(h=H+10, d=Dsupport-3, $fn=120); /*  */
}

translate([0, 0, -P / 2 ])
difference() {
  cylinder(h=5, d=28, $fn=6, center=true);
  cylinder(h=6, d=Dsupport-3, $fn=120, center=true); /*  */
}
