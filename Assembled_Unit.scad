// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Shell_Front.scad>
use <Face_Buttons.scad>
use <Aux_Buttons.scad>
use <DPad.scad>
use <Joycon_Analog_Stick.scad>
use <Mounts.scad>
use <Shoulder_Button.scad>
use <Screen.scad>

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
module assembly()
{
    color("white") front_shell();
    color("black") translate([0, 0, base_d - screen_glass_d]) screen();

    color("grey") translate(face_button_loc) face_button_cluster();
    color("grey") translate(start_sel_loc) aux_start_select_button_cluster();
    color("grey") translate(fn_button_loc) aux_fn_menu_button_cluster();
    color("grey") translate(home_button_loc) aux_home_button();
    color("grey") translate(dpad_loc) dpad();
    color("grey") translate(r_analog_loc - [0.0, 0.0, jc_d]) joycon_analog_module();
    color("grey") translate(l_analog_loc - [0.0, 0.0, jc_d]) joycon_analog_module();
    color("grey") translate(left_shoulder_btn_loc - [-.5,s_btn_pad_d + 0.5,0]) rotate(edge_rotation_deg + [180, 180, shoulder_angle_deg]) shoulder_button();
    color("grey") translate(right_shoulder_btn_loc - [-.5,s_btn_pad_d + 0.5,0]) rotate(edge_rotation_deg + [180, 0, -shoulder_angle_deg]) shoulder_button();
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
// Nothing to render
assembly();