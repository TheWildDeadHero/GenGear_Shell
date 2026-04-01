// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Button.scad>
use <Mounts.scad>

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

// Create the pin mount for the shhoulder button. Can create the on-button mount or the mount that's supposed to go into the housing.
module s_btn_pin_mount(wall=UNDEF, shell=false)
{
    pin_mount(dia=s_btn_mnt_dia,
              d=s_btn_mnt_d,
              bore_dia=s_btn_pin_dia,
              spring=s_btn_spring,
              wall=wall,
              top=!shell);
}

// --- MAIN BODY MODULES ---
/*
Create the main body modules
*/

// Create a shoulder button
module shoulder_button()
{
    union()
    {
        button(w=s_btn_w,
               h=s_btn_h,
               d=s_btn_d,
               pad_tol_n=s_btn_pad_tol_n,
               pad_tol_s=s_btn_pad_tol_s,
               pad_tol_e=s_btn_pad_tol_e,
               pad_tol_t=s_btn_pad_tol_t,
               pad_d=s_btn_pad_d,
               dome_dia=s_btn_dome_dia);

        // Add the pin mount
        rotate([90, 0, 0]) translate([-s_btn_w / 2 - s_btn_mnt_dia / 2 - s_btn_pad_tol_t, -s_btn_pad_d, -s_btn_h / 2 - s_btn_pad_tol_s]) s_btn_pin_mount();
    }
}

// Create a cutout for the shoulder button
module shouder_button_cutout()
{
    half_width  = s_btn_cutout_w / 2;
    half_height = s_btn_cutout_h / 2;

    linear_extrude(s_btn_cutout_d) hull()
    {
        translate([-(half_width - half_height), 0.0]) circle(d=s_btn_cutout_h);
        translate([ (half_width - half_height), 0.0]) circle(d=s_btn_cutout_h);
    } 
}

module shell_s_btn_pin_mount(left=false)
{
    rotate([90, 0, 0]) translate([-s_btn_w / 2 - s_btn_mnt_dia / 2 - s_btn_pad_tol_t, -s_btn_pad_d, -s_btn_h / 2 - s_btn_pad_tol_s]) rotate([0, 0, (left ? -1 : 1) * (shoulder_angle_deg + 90)])
    pin_mount(dia=s_btn_mnt_dia,
              d=s_btn_mnt_d,
              bore_dia=s_btn_pin_dia,
              spring=s_btn_spring,
              wall=0.0,
              top=false);
}
// --- RENDER ---
/*
Actually draw the main body
*/
//shoulder_button();

shell_s_btn_pin_mount(left=false);