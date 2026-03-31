// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>

// --- RENDER RESOLUTION ---
/*
Set the rendering resolution. Lower for lower-power systems.
*/
$fn = 128;

// --- DIMENSIONS ---
/*
Local dimensions that are specific to this drawing
*/

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/
// None

// --- MAIN BODY MODULES ---
/*
Create the main body module
*/

// Creates a Kailh Blue Micro through-hole switch
module kailh_blue_micro_th()
{  
    edge_dist = 4.0;
    dia       = 2 * kailh_sw_plunger_r;
    h         = 2.75;

    union()
    {
        // Main body
        translate([0.0, 0.0, kailh_sw_d / 2]) cube([kailh_sw_w, kailh_sw_h, kailh_sw_d], center=true);
        
        // Pins
        translate([-kailh_sw_pin_dist, 0.0, -kailh_sw_pin_length]) cylinder(d=kailh_sw_pin_pitch, h=kailh_sw_pin_length);
        translate([               0.0, 0.0, -kailh_sw_pin_length]) cylinder(d=kailh_sw_pin_pitch, h=kailh_sw_pin_length);
        translate([ kailh_sw_pin_dist, 0.0, -kailh_sw_pin_length]) cylinder(d=kailh_sw_pin_pitch, h=kailh_sw_pin_length);
        
        // Switch cylinder/plunger
        translate([kailh_sw_w / 2 - edge_dist, 0.0, kailh_sw_d]) rotate([90, 0, 0]) cylinder(d=dia, h=h, center=true);
    }
}

// --- RENDER ---
/*
Actually render the component
*/
kailh_blue_micro_th();