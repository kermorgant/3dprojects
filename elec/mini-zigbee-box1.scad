// Mini Zigbee Module Enclosure - Bottom
// Enclosure for 41x41mm zigbee module

// Parameters (all in mm)
module_size = 41;                   // Internal size for zigbee module
vertical_wall_thickness = 3;        // Thickness of top/bottom walls
horizontal_wall_thickness = 2;      // Thickness of left/right walls
bottom_thickness = 2.5;             // Thickness of bottom plate
top_wall_height = 15;               // Height of top wall above bottom
right_wall_height = 15;             // Height of right wall above bottom
bottom_wall_height = 3.5;           // Height of bottom wall above bottom
left_wall_height = 15;              // Height of left wall above bottom
hole_diameter = 20;                 // Center hole diameter

// Calculated values
outer_width = module_size + (2 * vertical_wall_thickness);      // Width (top to bottom direction)
outer_depth = module_size + (2 * horizontal_wall_thickness);    // Depth (left to right direction)
max_wall_height = max(top_wall_height, max(right_wall_height, max(bottom_wall_height, left_wall_height)));
total_height = bottom_thickness + max_wall_height;    // Total height based on tallest wall

// Main module
module zigbee_bottom() {
    $fn = 100;  // Smooth circles/arcs

    difference() {
        union() {
            // Bottom plate
            cube([outer_width, outer_depth, bottom_thickness]);

            // Top wall (front)
            cube([vertical_wall_thickness, outer_depth, bottom_thickness + top_wall_height]);

            // Bottom wall (back)
            translate([outer_width - vertical_wall_thickness, 0, 0])
                cube([vertical_wall_thickness, outer_depth, bottom_thickness + bottom_wall_height]);

            // Left wall
            cube([outer_width, horizontal_wall_thickness, bottom_thickness + left_wall_height]);

            // Right wall
            translate([0, outer_depth - horizontal_wall_thickness, 0])
                cube([outer_width, horizontal_wall_thickness, bottom_thickness + right_wall_height]);
        }

        // Center hole through bottom
        translate([outer_width/2, outer_depth/2, -0.1])
            cylinder(h = bottom_thickness + 0.2, d = hole_diameter);
    }
}

// Render
zigbee_bottom();
