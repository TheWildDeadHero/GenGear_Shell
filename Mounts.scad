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
// No functions

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/

// Create a post to mount a component
module mount_post(dia=pcb_mnt_dia, r=UNDEF, d=pcb_mnt_d, bore_dia=pcb_mnt_bore_dia, bore_r=UNDEF, bore_d=pcb_mnt_bore_d)
{
    // Determine main body dimensions
    dia = r == UNDEF ? dia : r * 2;
    
    // Determine the bore dimensions
    bore_dia = bore_r == UNDEF ? bore_dia : bore_r * 2;

    difference()
    {
        cylinder(d=dia, h=d);
        translate([0, 0, d - bore_d]) cylinder(d=bore_dia, h=bore_d);
    }
}

// Create a pin mount for hinged components
module pin_mount(dia=UNDEF, r=UNDEF, d=UNDEF, bore_dia=UNDEF, bore_r=UNDEF, spring=UNDEF, wall=UNDEF, top=false, tol=0.01)
{
    // Determine the main body diameter
    dia             = r == UNDEF ? dia : r * 2;
    
    // Determine the bore diameter
    bore_dia        = bore_r == UNDEF ? bore_dia : bore_r * 2;
    
    // Determine spacing dimensions. If undefined, assume 0.
    wall            = wall == UNDEF ? 0.0 : wall;
    spring          = spring == UNDEF ? 0.0 : spring;
    
    // Get the measurements for the mount
    total_w         = dia + wall;
    offset_w        = total_w - dia / 2;
    total_h         = dia;
    
    // Pre-calculate offsets
    body_offset_x   = -total_w / 2.0 + dia / 2.0;
    body_offset_y   = -dia / 2.0;
    
    // Calculate the height of each slice (before applying tolerance) - there are 4 slices used for a pin mount - 2 for each side
    slice_height = (d - spring) / 4.0;

    difference()
    {
        // Create the main solid
        union()
        {
            translate([body_offset_x,           0.0, 0.0]) cylinder(d=dia, h=d);
            translate([body_offset_x, body_offset_y, 0.0]) cube([wall + dia / 2.0, dia, d]);
        }
        
        // Create the shaft for the pin
        translate([body_offset_x, 0.0, 0.0]) cylinder(d=bore_dia, h=d);
        
        // Remove the spring space and slices that are a part of the complementing body
        // Remove depending on whether the "top" or the "botton" are specified.
        if (top)
        {
            translate([-total_w / 2, -total_h / 2,                0.0])                     cube([dia, dia, slice_height - tol / 2]);
            translate([-total_w / 2, -total_h / 2, slice_height * 2.0])                     cube([dia, dia, slice_height + spring - tol / 2]);
        }
        else
        {
            translate([-total_w / 2, -total_h / 2, slice_height + tol / 2])                 cube([dia, dia, slice_height - tol / 2]);
            translate([-total_w / 2, -total_h / 2, slice_height * 2.0])                     cube([dia, dia, spring]);
            translate([-total_w / 2, -total_h / 2, slice_height * 3.0 + spring + tol / 2])  cube([dia, dia, spring + slice_height - tol / 2]);
        }
    }
}

// --- MAIN BODY MODULES ---
/*
Modules that draws the main bodies of the components.
*/

// Draw a mounting post for the main PCB
module pcb_mount_post(dia=pcb_mnt_dia, r=UNDEF, d=pcb_mnt_d, bore_dia=pcb_mnt_bore_dia, bore_d=pcb_mnt_bore_d)
{
    mount_post(dia=dia, r=r, d=d, bore_dia=bore_dia, bore_d=bore_d);
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/

pcb_mount_post();