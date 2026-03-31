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

// Create a screen with glass
module screen()
{
    // Create some ajustments so it actually looks like the screen is there.
    screen_w_adjusted = screen_w - 0.01;
    screen_h_adjusted = screen_h - 0.01;

    translate([-screen_w_adjusted / 2, -screen_h_adjusted / 2, 0]) union()
    {
        cube([screen_w_adjusted, screen_h_adjusted, screen_glass_d]);
        translate([screen_lip_width, 0, -screen_panel_d]) cube([screen_w_adjusted - 2 * screen_lip_width, screen_h_adjusted - screen_lip_width, screen_panel_d]);
    }
}

// Create a cutout for the screen. Ensures that a support lip exists to make sure the screen is
// both supported and flush with the rest of the housing.
module screen_cutout()
{
    // Main cutout (fits around the glass of the screen)
    main_loc = [-screen_w/2, -screen_h/2, base_d - recess_depth];
    main_dim = [screen_w, screen_h, recess_depth];
    translate(main_loc) cube(main_dim);
    
    // Support lip cutout
    support_lip_loc = [-screen_w/2 + screen_lip_width, -screen_h/2, base_d - (3 * recess_depth)];
    support_lip_dim = [screen_w - (2 * screen_lip_width), screen_h - screen_lip_width, recess_depth * 3];
    translate(support_lip_loc) cube(support_lip_dim);
    
    // Control panel cutout
    control_panel_loc = [screen_w/2 - screen_lip_width, -(screen_h/2 - 18), base_d - (3 * recess_depth)];
    control_panel_dim = [screen_lip_width, screen_btn_d, recess_depth * 3];
    translate(control_panel_loc) cube(control_panel_dim);

    // Screen mounting post cutouts
    screen_post_depth     = recess_depth * 3;
    post_cutout_width     = 4.0;
    post_cutout_height    = 8.0;
 
    upper_screen_post_loc = [-screen_w/2,  (screen_h/2 - (screen_t_post_offset) - (post_cutout_height / 2)), base_d - (3 * recess_depth)];
    lower_screen_post_loc = [-screen_w/2, -(screen_h/2 - (screen_b_post_offset) + (post_cutout_height / 2)), base_d - (3 * recess_depth)];
    
    translate(upper_screen_post_loc) cube([post_cutout_width, post_cutout_height, screen_post_depth]);
    translate(lower_screen_post_loc) cube([post_cutout_width, post_cutout_height, screen_post_depth]);
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/
screen();