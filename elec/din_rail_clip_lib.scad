//-------------------------------------------------------------------
// title: DIN Rail Clip Library
// description: Reusable module for creating DIN rail mounting clips
// designed as separate glue-on components
// based on: OK1HRA's design (http://remoteqth.com/3d-din-rail-mount-clip.php)
// license: Creative Commons BY-SA
// revision: 2.0
// format: OpenSCAD
//-------------------------------------------------------------------
// Standard DIN rail: 35mm wide, 7.5mm deep mounting channel
// Clips are designed to be printed separately and glued onto your project
//-------------------------------------------------------------------

/**
 * din_rail_clip_side_mount - DIN rail clip for side mounting (minimizes depth)
 *
 * This creates a thin clip profile that lies flat for side mounting.
 * Just the clip profile rotated 90 degrees - no perpendicular gluing surface.
 * Print separately and glue the flat back to your enclosure side.
 * Best for minimizing the depth added to your project.
 *
 * Parameters:
 *   clip_height - Height along the DIN rail (default: 55mm)
 *   clip_thickness - Thickness of the clip itself (default: 3mm, thin for side mount)
 *
 * Usage:
 *   din_rail_clip_side_mount();
 *   din_rail_clip_side_mount(clip_height=40, clip_thickness=2.5);
 */
module din_rail_clip_side_mount(
    clip_height=55,
    clip_thickness=3
) {
    // The DIN rail clip profile (rotated for side mounting)
    // The flat back surface is ready for gluing
    rotate([0, -90, 0])
    translate([0, 0, -clip_thickness])
        din_rail_clip_profile(height=clip_thickness, length=clip_height);
}


/**
 * din_rail_clip_profile - Internal module for the basic clip geometry
 *
 * Creates just the DIN rail hook profile without any mounting features.
 * This is the core geometry used by other modules.
 *
 * Parameters:
 *   height - Height/thickness of the clip (direction perpendicular to rail)
 *   length - Length along the rail (default: 55mm)
 *
 * Note: This is typically used internally by other modules, but can be used
 * directly if you need the raw profile for custom applications.
 */
module din_rail_clip_profile(height=7, length=55) {
    width_expand = 0; // Keep profile compact for glue-on design

    // Main clip body and hook mechanism
    union() {
        // Top hook - grips the top lip of DIN rail
        hull() {
            translate([15+width_expand, length-2, 0])
                cylinder(h=height, r=2, center=false);
            translate([12+width_expand, 37.5, 0])
                cube([5, 1, height], center=false);
            translate([12+width_expand, length-1, 0])
                cube([1, 1, height], center=false);
        }

        // Secondary hook element - provides grip strength
        hull() {
            translate([16+width_expand, 35.7, 0])
                cylinder(h=height, r=1, center=false);
            translate([14.2+width_expand, 37.5, 0])
                cube([2.8, 1, height], center=false);
        }

        // Lower clip curve - hooks under DIN rail lip
        hull() {
            translate([18.5+width_expand, 0.5, 0])
                cylinder(h=height, r=0.5, center=false);
            translate([14.5+width_expand, 3.8, 0])
                cylinder(h=height, r=0.3, center=false);
            translate([14.2+width_expand, 0, 0])
                cube([1, 1, height], center=false);
        }

        // Base mounting surface elements
        cube([3.5, 4, height], center=false);
        cube([15+width_expand, 2, height], center=false);

        // Main vertical back plate
        hull() {
            translate([12+width_expand, 4, 0])
                cylinder(h=height, r=1, center=false);
            translate([0, 3, 0])
                cube([1, 1, height], center=false);
            translate([0, length-1, 0])
                cube([13+width_expand, 1, height], center=false);
        }
    }
}

/**
 * din_rail_clip_with_mount - DIN clip with integrated mounting holes
 *
 * Creates a DIN rail clip with a mounting plate and screw holes.
 *
 * Parameters:
 *   height - Thickness of the clip
 *   screw_distance - Distance between mounting screws (default: 40mm)
 *   screw_radius - Radius of mounting screw holes (default: 1.7mm for M3)
 *   indentation - Depth of side tabs (default: 3mm)
 *   length - Length along the rail
 *   width_expand - Extra width extension
 *
 * Usage:
 *   din_rail_clip_with_mount();
 *   din_rail_clip_with_mount(screw_distance=50, screw_radius=2);
 */
module din_rail_clip_with_mount(
    height=7,
    screw_distance=40,
    screw_radius=1.7,
    indentation=3,
    length=55,
    width_expand=1
) {
    difference() {
        union() {
            // The DIN rail clip profile
            din_rail_clip(
                height=height,
                length=length,
                width_expand=width_expand
            );

            // Mounting plate extension
            hull() {
                translate([0, 40, 0])
                    cube([14, 1, height], center=false);
                translate([2, screw_distance+14, 0])
                    cylinder(h=height, r=2, center=false);
                translate([6, screw_distance+14, 0])
                    cylinder(h=height, r=2, center=false);
            }

            // Side indentation tabs (for grip or clearance)
            translate([-indentation, 10.5-3.5, 0])
                cube([indentation+1, 7, height], center=false);
            translate([-indentation, 10.5-3.5+screw_distance, 0])
                cube([indentation+1, 7, height], center=false);
        }

        // Small pilot hole at base
        translate([3.5, 2.5, -1])
            cylinder(h=height+2, r=0.5, center=false);

        // Retention/ventilation hole
        translate([9+width_expand, -1, height/2])
            rotate([-90, 0, 0])
                cylinder(h=16, r=screw_radius, center=false);
        translate([6.15+width_expand, 5, -1])
            cube([5.7, 3.9, height+2], center=false);

        // First mounting screw hole (horizontal)
        translate([-1-indentation, 10.5, height/2])
            rotate([0, 90, 0])
                cylinder(h=9+width_expand+indentation, r=screw_radius, center=false);
        translate([2, 7.65, -1])
            cube([3.9, 5.7, height+2], center=false);

        // Second mounting screw hole (horizontal)
        translate([-1-indentation, 10.5+screw_distance, height/2])
            rotate([0, 90, 0])
                cylinder(h=11+width_expand+indentation, r=screw_radius, center=false);
        translate([2, 7.65+screw_distance, -1])
            cube([3.9, 5.7, height+2], center=false);
    }
}

//-------------------------------------------------------------------
// EXAMPLES - Uncomment to test
//-------------------------------------------------------------------

// Example 1: Side-mount clip (minimizes depth - only 3mm thick!)
// Best for: Gluing to the side of enclosures
$fn = 50;
// din_rail_clip_side_mount();

// // Example 2: Thinner clip for very shallow enclosures
// translate([30, 0, 0])
//     din_rail_clip_side_mount(clip_thickness=2.5);

// Example 3: Clip sized to match 47mm zigbee box
translate([60, 0, 0])
    din_rail_clip_side_mount(clip_height=47);

// Example 4: Using with your main model
// cube([50, 60, 30]);
/*
// Your main enclosure with a flat side

// The clip positioned to glue on the side (print separately)
translate([50, 30, 15])
    rotate([0, 0, 90])
        din_rail_clip_side_mount();
*/

// Example 5: Legacy - Original clip with integrated mounting holes
// Use this if you want the original all-in-one design with screw holes
// translate([0, 140, 0])
//     din_rail_clip_with_mount();
