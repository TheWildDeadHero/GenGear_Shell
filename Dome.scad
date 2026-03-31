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

// --- FUNCTIONS ---
/*
Functions that make the code more legible and reusable
*/

// Get the radius depending on if the diameter or radius is defined.
//
function dome_get_r(r, dia) = r == UNDEF ? dia / 2 : r;

// Get the greater sphere radius from the sole defined value between the sphere diameter, the sphere radius, the arc angle in degress, and the arc angle in radians.
//
function dome_get_sphere_r(r, sdia, sr, deg, rad) = sdia == UNDEF ? (sr == UNDEF ? (deg == UNDEF ? (rad == UNDEF ? r : (r / sin(rad * (180 / PI)))) : r / sin(deg)) : sr) : sdia;

// Get the depth of the dome given the dome radius and the greater sphere radius.
//
function dome_get_d(r=UNDEF, dia=UNDEF, sdia=UNDEF, sr=UNDEF, deg=UNDEF, rad=UNDEF) = 
        let(_r = dome_get_r(r, dia)) 
        let(_sr = dome_get_sphere_r(_r, sdia, sr, deg, rad))
        _sr - sqrt(_sr^2 - _r^2);

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/
// No sub modules

// --- MAIN BODY MODULES ---
/*
Module that draws the main body of the component.
*/

// Draws a dome
module dome(r=UNDEF, dia=UNDEF, sphere_dia=UNDEF, sphere_r=UNDEF, angle_deg=UNDEF, angle_rad=UNDEF)
{   
    // Actually get the variables used to calculate the dome
    r        = dome_get_r(r, dia);
    sphere_r = dome_get_sphere_r(r, sphere_dia, sphere_r, angle_deg, angle_rad);
    
    // This is the Z-value distance from the center of the greater sphere to the dome
    distance_from_center = sqrt(sphere_r^2 - r^2);

    // Create the dome. The dome is created by taking the difference of the greater sphere and a cube and translating that distance back to
    // the point of origin.
    translate([0, 0, -distance_from_center]) difference()
    {
        sphere(sphere_r);
        translate([-sphere_r, -sphere_r, -sphere_r - distance_from_center]) cube([sphere_r * 2, sphere_r * 2, sphere_r + 2 * distance_from_center]);
    }
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
// Uncomment to test the dome() module.
dome(r=12, angle_rad=PI/2);