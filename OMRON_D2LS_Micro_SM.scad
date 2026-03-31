// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad> // Needs UNDEF
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
// No main body modules
module omron_d2ls_sm(center_at_plunger=false)
{
    translation = center_at_plunger ? [-(omron_d2ls_w / 2 - omron_d2ls_plunger_offset), 0.0, -omron_d2ls_d] : [0.0, 0.0, 0.0];

    translate(translation) union()
    {
        // Main body
        color("blue") translate([0.0, 0.0, omron_d2ls_d / 2]) cube([omron_d2ls_w, omron_d2ls_h, omron_d2ls_d], center=true);
        
        // Switch cylinder/plunger
        color("blue") translate([omron_d2ls_w / 2 - omron_d2ls_plunger_offset, 0.0, omron_d2ls_d]) rotate([90, 0, 0]) cylinder(d=omron_d2ls_plunger_dia, h=omron_d2ls_plunger_w, center=true);
        
        color("black") translate([omron_d2ls_boss_dist / 2, 0.0, -omron_d2ls_boss_d + omron_d2ls_boss_dia / 2]) cylinder(d=omron_d2ls_boss_dia, h=omron_d2ls_boss_d - omron_d2ls_boss_dia / 2);
        color("black") translate([omron_d2ls_boss_dist / 2, 0.0, -omron_d2ls_boss_d + omron_d2ls_boss_dia / 2]) rotate([180, 0, 90]) dome(dia=omron_d2ls_boss_dia);
        
        color("black") translate([-omron_d2ls_boss_dist / 2, 0.0, -omron_d2ls_boss_d + omron_d2ls_boss_dia / 2]) cylinder(d=omron_d2ls_boss_dia, h=omron_d2ls_boss_d - omron_d2ls_boss_dia / 2);
        color("black") translate([-omron_d2ls_boss_dist / 2, 0.0, -omron_d2ls_boss_d + omron_d2ls_boss_dia / 2]) rotate([0, 180, 0]) dome(dia=omron_d2ls_boss_dia);
    }
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
omron_d2ls_sm(center_at_plunger=true);