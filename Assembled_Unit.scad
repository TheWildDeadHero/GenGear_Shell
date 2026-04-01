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
use <Kailh_Blue_Micro_TH.scad>
use <OMRON_D2LS_Micro_SM.scad>
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
module assembly(th_switches=false)
{
    color("white") front_shell();
    color("black") translate([0, 0, base_d - screen_glass_d]) screen();

    color("grey") translate(face_button_loc) face_button_cluster();
    color("grey") translate(start_sel_loc) aux_start_select_button_cluster();
    color("grey") translate(fn_button_loc) aux_fn_menu_button_cluster();
    color("grey") translate(home_button_loc) aux_home_button();
    color("grey") translate(r_analog_loc - [0.0, 0.0, jc_d]) joycon_analog_module();
    color("grey") translate(l_analog_loc - [0.0, 0.0, jc_d]) joycon_analog_module();
    
    color("grey") translate(left_shoulder_btn_loc) rotate(edge_rotation_deg + [180, 180, shoulder_angle_deg]) translate([0, 0.0, -s_btn_d - wall_thickness]) shoulder_button();
    color("grey") translate(right_shoulder_btn_loc) rotate(edge_rotation_deg + [180, 0, -shoulder_angle_deg]) translate([0, 0.0, -s_btn_d - wall_thickness]) shoulder_button();
    
    if (th_switches) // Use the larger Kailh Blue through_hole micro switches
    {
        // The switch size affects the length of the pivot, so adjust accordingly
        color("grey") translate(dpad_loc) dpad(pivot_d=kailh_sw_d);

        translate(face_btn_coordinates[0] + face_button_loc - [0.0, 0.0, kailh_sw_plunger_r + face_btn_ret_d]) rotate([0.0, 0.0, -shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(face_btn_coordinates[1] + face_button_loc - [0.0, 0.0, kailh_sw_plunger_r + face_btn_ret_d]) rotate([0.0, 0.0, -shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(face_btn_coordinates[2] + face_button_loc - [0.0, 0.0, kailh_sw_plunger_r + face_btn_ret_d]) rotate([0.0, 0.0, -shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
    
        translate(face_btn_coordinates[0] + face_button_loc + xyz_btn_offset - [0.0, 0.0, kailh_sw_plunger_r + face_btn_ret_d]) rotate([0.0, 0.0, -shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(face_btn_coordinates[1] + face_button_loc + xyz_btn_offset - [0.0, 0.0, kailh_sw_plunger_r + face_btn_ret_d]) rotate([0.0, 0.0, -shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(face_btn_coordinates[2] + face_button_loc + xyz_btn_offset - [0.0, 0.0, kailh_sw_plunger_r + face_btn_ret_d]) rotate([0.0, 0.0, -shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
    
        translate(dpad_loc - [0.0, -dpad_pad_dia / 2 + 3.0, kailh_sw_plunger_r + dpad_ret_d]) rotate([0.0, 0.0, shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(dpad_loc - [0.0,  dpad_pad_dia / 2 - 3.0, kailh_sw_plunger_r + dpad_ret_d]) rotate([0.0, 0.0, 180.0 + shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(dpad_loc - [-dpad_pad_dia / 2 + 3.0, 0.0, kailh_sw_plunger_r + dpad_ret_d]) rotate([0.0, 0.0, 270.0 + shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
        translate(dpad_loc - [ dpad_pad_dia / 2 - 3.0, 0.0, kailh_sw_plunger_r + dpad_ret_d]) rotate([0.0, 0.0, 90.0 + shoulder_angle_deg]) kailh_blue_micro_th(center_at_plunger=true);
    }
    else // Use the smaller OMRON D2LS surface-mount micro switches
    {
        // The switch size affects the length of the pivot, so adjust accordingly
        color("grey") translate(dpad_loc) dpad(pivot_d=omron_d2ls_d);

        translate(face_btn_coordinates[0] + face_button_loc - [0.0, 0.0, omron_d2ls_plunger_dia / 2 + face_btn_ret_d]) omron_d2ls_sm(center_at_plunger=true);
        translate(face_btn_coordinates[1] + face_button_loc - [0.0, 0.0, omron_d2ls_plunger_dia / 2 + face_btn_ret_d]) omron_d2ls_sm(center_at_plunger=true);
        translate(face_btn_coordinates[2] + face_button_loc - [0.0, 0.0, omron_d2ls_plunger_dia / 2 + face_btn_ret_d]) omron_d2ls_sm(center_at_plunger=true);
    
        translate(face_btn_coordinates[0] + face_button_loc + xyz_btn_offset - [0.0, 0.0, omron_d2ls_plunger_dia / 2 + face_btn_ret_d]) omron_d2ls_sm(center_at_plunger=true);
        translate(face_btn_coordinates[1] + face_button_loc + xyz_btn_offset - [0.0, 0.0, omron_d2ls_plunger_dia / 2 + face_btn_ret_d]) omron_d2ls_sm(center_at_plunger=true);
        translate(face_btn_coordinates[2] + face_button_loc + xyz_btn_offset - [0.0, 0.0, omron_d2ls_plunger_dia / 2 + face_btn_ret_d]) omron_d2ls_sm(center_at_plunger=true);
    
        translate(dpad_loc - [0.0, -dpad_pad_dia / 2 + 3.0, omron_d2ls_plunger_dia / 2 + dpad_ret_d]) rotate([0.0, 0.0, 0.0]) omron_d2ls_sm(center_at_plunger=true);
        translate(dpad_loc - [0.0,  dpad_pad_dia / 2 - 3.0, omron_d2ls_plunger_dia / 2 + dpad_ret_d]) rotate([0.0, 0.0, 180.0]) omron_d2ls_sm(center_at_plunger=true);
        translate(dpad_loc - [-dpad_pad_dia / 2 + 3.0, 0.0, omron_d2ls_plunger_dia / 2 + dpad_ret_d]) rotate([0.0, 0.0, 270.0]) omron_d2ls_sm(center_at_plunger=true);
        translate(dpad_loc - [ dpad_pad_dia / 2 - 3.0, 0.0, omron_d2ls_plunger_dia / 2 + dpad_ret_d]) rotate([0.0, 0.0, 90.0]) omron_d2ls_sm(center_at_plunger=true);       
    }
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
// Nothing to render
assembly();