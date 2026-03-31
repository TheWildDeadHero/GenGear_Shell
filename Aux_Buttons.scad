// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Button.scad>

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

// Generic aux button factory module - creates auxillary buttons with the dimensions defined in this file
module generic_aux_btn(keys)
{
    button(dia=aux_btn_dia,
           d=aux_btn_d,
           pad_dia=aux_btn_pad_dia,
           pad_d=aux_btn_pad_d,
           dome_dia=aux_btn_dome_dia,
           pad_keys=keys,
           key_w_deg=aux_btn_key_deg);
}

// Generic aux button cutout factory module - creates auxillary button cutouts with the dimensions defined in this file
module generic_aux_btn_cutout()
{
    cylinder(d=aux_btn_cutout_dia, h=aux_btn_cutout_d);
}

// Generic aux button retainer factory module - - creates auxillary button retainers with the dimensions defined in this file
module generic_aux_btn_retainer(keys)
{
    circle_button_retainer(dia=aux_btn_cutout_dia,
                           d=aux_btn_ret_d,
                           thickness=aux_btn_ret_thickness,
                           keys=keys,
                           key_w_deg=aux_btn_key_deg + aux_btn_key_deg_tol);
}

// --- MAIN BODY MODULES ---
/*
Modules that draws the main bodies of the components.
*/

// Create the function and menu button cluster
module aux_fn_menu_button_cluster()
{
    translate([ aux_btn_dist / 2, 0, 0]) generic_aux_btn(aux_btn_menu_keys);
    translate([-aux_btn_dist / 2, 0, 0]) generic_aux_btn(aux_btn_fn_keys);
}

// Create the start and select menu button cluster
module aux_start_select_button_cluster()
{
    translate([ aux_btn_dist / 2, 0, 0]) generic_aux_btn(aux_btn_start_keys);
    translate([-aux_btn_dist / 2, 0, 0]) generic_aux_btn(aux_btn_select_keys);
}

// Create the singular home button
module aux_home_button()
{
    generic_aux_btn(aux_btn_home_keys);
}

// Create the cutouts for a cluster of auxillary buttons
module aux_button_cutouts()
{
    translate([ aux_btn_dist / 2, 0, 0]) generic_aux_btn_cutout();
    translate([-aux_btn_dist / 2, 0, 0]) generic_aux_btn_cutout();
}

// Create a cutout just for the home button
module aux_home_button_cutout()
{
    generic_aux_btn_cutout();
}

// Create a set of retainers for the function and menu buttons using their keys
module aux_fn_menu_button_retainers()
{
    translate([ aux_btn_dist / 2, 0, 0]) generic_aux_btn_retainer(aux_btn_menu_keys);
    translate([-aux_btn_dist / 2, 0, 0]) generic_aux_btn_retainer(aux_btn_fn_keys);
}

// Create a set of retainers for the start and select buttons using their keys
module aux_start_select_button_retainers()
{
    translate([ aux_btn_dist / 2, 0, 0]) generic_aux_btn_retainer(aux_btn_start_keys);
    translate([-aux_btn_dist / 2, 0, 0]) generic_aux_btn_retainer(aux_btn_select_keys);
}

// Create a retainer for the home button using the keys defined in this file
module aux_home_button_retainer()
{
    generic_aux_btn_retainer(aux_btn_home_keys);
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
aux_home_button();
translate([0, 0, -aux_btn_pad_d]) aux_home_button_retainer();

translate([0, 15, 0]) aux_start_select_button_cluster();
translate([0, 15, -aux_btn_pad_d]) aux_start_select_button_retainers();

translate([0, -15, 0]) aux_fn_menu_button_cluster();
translate([0, -15, -aux_btn_pad_d]) aux_fn_menu_button_retainers();