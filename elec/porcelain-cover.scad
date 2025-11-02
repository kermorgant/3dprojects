// Porcelain fuse mount cover for Finnish electric panel
// Based on original cover measurements

// Parameters (all in mm)
outer_diameter = 48.5;    // Outer diameter of the cover (extends over panel)
inner_diameter = 44.1;    // Diameter of the clip/lip that goes into the hole (reduced from 44.2)
cover_width = 1.5;        // Width of the main cover plate
clip_width = 1.8;         // Width of the clip/lip that sticks into hole

// Reinforcement ring parameters
ring_width = 3;           // Width of the reinforcement ring (radial)
ring_thickness = 4;       // Thickness of the ring (axial/height)

// Calculated values
outer_radius = outer_diameter / 2;
inner_radius = inner_diameter / 2;
ring_outer_radius = inner_radius;
ring_inner_radius = inner_radius - ring_width;

// Main module
module porcelain_cover() {
        union() {
            // Main cover plate (the part that sits on top of the panel)
            cylinder(h = cover_width, r = outer_radius, $fn=100);

            // Clip/lip (the part that goes into the hole)
            translate([0, 0, cover_width])
                cylinder(h = clip_width, r = inner_radius, $fn=100);

            // Reinforcement ring at the base of the clip (saves filament vs full disc)
            translate([0, 0, cover_width + clip_width])
                difference() {
                    cylinder(h = ring_thickness, r = ring_outer_radius, $fn=100);
                    // Hollow out the center to save filament
                    translate([0, 0, -0.1])
                        cylinder(h = ring_thickness + 0.2, r = ring_inner_radius, $fn=100);
                }
        }

        // You can add holes or other features here if needed
        // For example, a center hole for accessing fuses:
        // translate([0, 0, -0.1])
        //     cylinder(h = cover_width + clip_width + ring_thickness + 0.2, r = 5, $fn=50);
}

// Render the cover
porcelain_cover();
