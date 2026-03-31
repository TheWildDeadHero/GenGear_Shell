// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Dome.scad>

// --- RENDER RESOLUTION ---
/*
Set the rendering resolution. Lower for lower-power systems.
*/
$fn = 128;

// --- DIMENSIONS ---
/*
Local dimensions that are specific to this drawing
*/

// --- FUNCTIONS ---
/*
Functions that make the code more legible and reusable
*/
// No functions

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/

// Create a small pivot so the DPad cannot press cross directions or all 4 directions simultaneously
module dpad_pivot(dia=dpad_pivot_dia, d=dpad_pivot_d)
{
    main_cyl_d = dpad_pivot_d - dpad_pivot_dia / 2;

    union()
    {
        cylinder(d=dpad_pivot_dia, h=main_cyl_d);
        translate([0, 0, main_cyl_d]) dome(dia=dpad_pivot_dia);
    }
}

// Create a round interface pad for the DPad
module dpad_pad()
{
    linear_extrude(dpad_pad_d) union()
    {
        circle(d=dpad_pad_dia);
        translate([-dpad_pad_key_w / 2, dpad_pad_dia / 2 - dpad_pad_key_h]) square([dpad_pad_key_w, dpad_pad_key_h + dpad_pad_key]);
    }
}

// --- MAIN BODY MODULES ---
/*
Create the main body modules
*/

// Create a D-pad solid - In FreeCAD, fillet the edge of the raised "plus" wit 1mm. Fillet the disc with 0.4mm.
module dpad()
{
    cutout_side         = dpad_dia / 2;
    half_dir_width      = dpad_dir_w / 2;
    dir_cutout_z_offset = dpad_d / 2 - 1.0;

    union()
    {
        // Create the main DPad disc
        difference()
        {
            cylinder(d=dpad_dia, h=dpad_d);

            translate([0.0, 0.0, dpad_contour_d_offset]) sphere(d=dpad_contour_dia);
            translate([0.0, 0.0, dpad_ctr_d_offset])     sphere(d=dpad_ctr_indent_dia);

            translate([half_dir_width,                    half_dir_width,                dir_cutout_z_offset]) cube([cutout_side, cutout_side, dpad_d]);
            translate([half_dir_width,                  -(half_dir_width + cutout_side), dir_cutout_z_offset]) cube([cutout_side, cutout_side, dpad_d]);
            translate([-(half_dir_width + cutout_side), -(half_dir_width + cutout_side), dir_cutout_z_offset]) cube([cutout_side, cutout_side, dpad_d]);
            translate([-(half_dir_width + cutout_side),   half_dir_width,                dir_cutout_z_offset]) cube([cutout_side, cutout_side, dpad_d]);
        }
 
        // Create the interface pad
        translate([0.0, 0.0, -dpad_pad_d]) dpad_pad();
        
        // Add the pivot
        translate([0.0, 0.0, -dpad_pad_d]) rotate([180.0, 0.0, 0.0]) dpad_pivot();
    }
}

// Create a cutout for the DPad
module dpad_cutout()
{
    cylinder(d=dpad_cutout_dia, h=dpad_cutout_d);
}

// Create a retension wall for the DPad
module dpad_retainer()
{   
    kw = dpad_pad_key_w + dpad_ret_offset;
    kh = dpad_ret_dia / 2 + dpad_ret_thickness - dpad_dia / 2;

    difference()
    {
        // Create the solid out of the outer wall dimensions
        cylinder(d=dpad_ret_dia + 2 * dpad_ret_thickness, h=dpad_ret_d);
        
        // Create the actual hole the DPad will go into
        cylinder(d=dpad_ret_dia, h=dpad_ret_d);
        
        // Add the key that prevents the DPad from being rotated
        if (kh > 0) translate([-kw / 2, dpad_dia / 2, 0]) cube([kw, kh, dpad_ret_d]);
    }
}

// --- RENDER ---
/*
Actually draw the main shell - Just draw the DPad
*/
dpad();
translate([0, 0, -dpad_pad_d]) dpad_retainer();