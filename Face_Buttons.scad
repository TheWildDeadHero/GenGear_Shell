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

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/

// Generic button factory module
module generic_face_button(letter=UNDEF,
                           keys=[])
{
    difference()
    {
        button(dia=face_btn_dia,
               d=face_btn_d,
               pad_dia=face_btn_pad_dia,
               pad_d=face_btn_pad_d,
               dome_dia=face_btn_dome_dia,
               pad_keys=keys,
               key_w_deg=face_btn_key_deg);
        
        // Only add a leter if one exists
        if (letter != UNDEF)
            translate([0.0, 0.0, face_btn_txt_offset]) linear_extrude(face_btn_txt_d) text(letter, size=face_btn_txt_size, halign=face_btn_txt_halign, valign=face_btn_txt_valign);
    }
}

// Generic button retainer factory module
module generic_face_btn_retainer(keys)
{
    circle_button_retainer(dia=face_btn_cutout_dia,
                           d=face_btn_ret_d,
                           thickness=face_btn_ret_thickness,
                           keys=keys,
                           key_w_deg=face_btn_key_deg + face_btn_key_deg_tol);
}

// Generic face button cutout factory module
module generic_face_btn_cutout()
{
    cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
}

// Create an A button with a unique key
module face_button_a()
{
    generic_face_button(letter="A", keys=face_btn_a_keys);
}

// Create an B button with a unique key
module face_button_b()
{
    generic_face_button(letter="B", keys=face_btn_b_keys);
}

// Create an C button with a unique key
module face_button_c()
{
    generic_face_button(letter="C", keys=face_btn_c_keys);
}

// Create an X button with a unique key
module face_button_x()
{
    generic_face_button(letter="X", keys=face_btn_x_keys);
}

// Create an Y button with a unique key
module face_button_y()
{
    generic_face_button(letter="Y", keys=face_btn_y_keys);
}

// Create an Z button with a unique key
module face_button_z()
{
    generic_face_button(letter="Z", keys=face_btn_z_keys);
}

// --- MAIN BODY MODULES ---
/*
Modules that draws the main bodies of the components.
*/

// Create a cluster of face buttons
module face_button_cluster()
{
    translate(face_btn_coordinates[0]) face_button_a();
    translate(face_btn_coordinates[1]) face_button_b();
    translate(face_btn_coordinates[2]) face_button_c();
    
    translate(face_btn_coordinates[0] + xyz_btn_offset) face_button_x();
    translate(face_btn_coordinates[1] + xyz_btn_offset) face_button_y();
    translate(face_btn_coordinates[2] + xyz_btn_offset) face_button_z();
}

// Create cutouts for the face buttons
module face_button_cutouts()
{
    translate(face_btn_coordinates[0]) cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
    translate(face_btn_coordinates[1]) cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
    translate(face_btn_coordinates[2]) cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
    
    translate(face_btn_coordinates[0] + xyz_btn_offset) cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
    translate(face_btn_coordinates[1] + xyz_btn_offset) cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
    translate(face_btn_coordinates[2] + xyz_btn_offset) cylinder(d=face_btn_cutout_dia, h=face_btn_cutout_d);
}

// Create retention walls for the buttons
module face_button_retainers()
{
    translate(face_btn_coordinates[0]) generic_face_btn_retainer(face_btn_a_keys);
    translate(face_btn_coordinates[1]) generic_face_btn_retainer(face_btn_b_keys);
    translate(face_btn_coordinates[2]) generic_face_btn_retainer(face_btn_c_keys);
    
    translate(face_btn_coordinates[0] + xyz_btn_offset) generic_face_btn_retainer(face_btn_x_keys);
    translate(face_btn_coordinates[1] + xyz_btn_offset) generic_face_btn_retainer(face_btn_y_keys);
    translate(face_btn_coordinates[2] + xyz_btn_offset) generic_face_btn_retainer(face_btn_z_keys);
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
face_button_cluster();
translate([0, 0, -face_btn_pad_d]) face_button_retainers();