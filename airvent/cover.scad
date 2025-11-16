// Sliding Ventilation Cover - Cover Component
// This cover slides in the frame rails to open/close the ventilation hole

// ===== PARAMETERS =====
// Must match frame.scad parameters
cover_size = 95;           // Size of the square cover
wall_thickness = 3;        // Thickness of the cover plate
rail_height = 2;           // Height of rails (from frame)
clearance = 0.25;          // Clearance for smooth sliding

hole_radius = 32.5;
hole_diameter = hole_radius * 2;

overlap = 12;
cover_radius = hole_radius + overlap;
  
// Finger hole in top section
finger_hole_radius = 12;  // ~24mm diameter hole
finger_hole_offset = cover_radius * 1.2;  // Position in top circle area
finger_ring_height = 3;   // Height of raised ring around hole

module cover() {
  difference() {
    union() {
      cylinder(h=wall_thickness, r = cover_radius, $fn=100, center=true);
      // Square plate with side = diameter of cylinder
      translate([0, cover_radius/2, 0])
        cube([cover_radius * 2, cover_radius , wall_thickness], center=true);

      translate([0, cover_radius, 0])
        cylinder(h=wall_thickness, r = cover_radius, $fn=100, center=true);

      // Chamfered ring around finger hole
      translate([0, finger_hole_offset, wall_thickness/2])
        difference() {
          cylinder(h=finger_ring_height, r1=finger_hole_radius+6, r2=finger_hole_radius+3, $fn=60);
          cylinder(h=finger_ring_height+1, r=finger_hole_radius, $fn=60);
        }
    }
    // Finger hole
    translate([0, finger_hole_offset, 0])
      cylinder(h=wall_thickness + finger_ring_height + 1, r = finger_hole_radius, $fn=60, center=true);
  }
}

cover();
