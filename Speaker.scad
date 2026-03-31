// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad> // Needs UNDEF

// --- RENDER RESOLUTION ---
/*
Set the rendering resolution. Lower for lower-power systems.
*/
$fn = 128;

// --- DIMENSIONS ---
/*
Local dimensions that are specific to this drawing
*/
// No local dimensions available

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
// No submodules

// --- MAIN BODY MODULES ---
/*
Modules that draws the main bodies of the components.
*/
// Create a grid of holes for a speaker
module speaker_grill()
{
    for (hole_y = [0:spk_grill_grid_spacing:spk_grill_height],
         hole_x = [0:spk_grill_grid_spacing:spk_grill_width])
    {
        translate([hole_x, hole_y, 0]) cylinder(d=spk_grill_hole_dia, h=wall_thickness);
    }
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
// Nothing to render