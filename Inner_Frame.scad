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

// Draw the main plate solid before cutouts
module inner_frame_solid()
{
    scale(frame_scale) hull()
    {
        for (corner = main_body_corners)
            translate(corner) cylinder(r=main_body_corner_radius, h=frame_thickness);
    }
}

// Create a cutout for the single-board computer
module sbc_cutout()
{
    cube([sbc_cutout_w, sbc_cutout_h, frame_thickness]);
}

// Create a cutout for the HDMI cable
module hdmi_cutout()
{
    cube([hdmi_cutout_w, hdmi_cutout_h, frame_thickness]);
}

// --- MAIN BODY MODULES ---
/*
Create the main body modules
*/

// Actually create the inner frame
module inner_frame_v1()
{
    difference()
    {
        inner_frame_solid();
       
        translate(sbc_cutout_offset) sbc_cutout();
        translate(hdmi_cutout_offset) hdmi_cutout();
       
        translate([ screen_w / 2 - screen_post_outer_dia / 2 + mount_hole_x_offset_right, screen_h / 2 - mount_hole_y_offset]) cylinder(d=mount_hole_dia, h=frame_thickness);
        translate([-screen_w / 2 + screen_post_outer_dia / 2 + mount_hole_x_offset_left,  screen_h / 2 - mount_hole_y_offset]) cylinder(d=mount_hole_dia, h=frame_thickness);
    }
}

// Creates a 2D projection of the 3D object
//
// Note - To work with KiCAD, export as a DXF
//
module pcb_shape()
{
    projection(cut=false) inner_frame_solid();
}

// --- RENDER ---
/*
Actually draw the main shell - in this case, just draw the PCB shape to be exported.
*/
inner_frame_v1();