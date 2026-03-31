// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Face_Buttons.scad>
use <Aux_Buttons.scad>
use <DPad.scad>
use <Joycon_Analog_Stick.scad>
use <Mounts.scad>
use <Shoulder_Button.scad>
use <Speaker.scad>
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

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/

// Create a cutout for a USB-C recepticle
module usb_c_cutout()
{
    hull()
    {
        translate([          0, usb_c_height / 2, 0]) cylinder(d=usb_c_height, wall_thickness);
        translate([usb_c_width, usb_c_height / 2, 0]) cylinder(d=usb_c_height, wall_thickness);
    }
}

// Create a cutout for a MicroSD card slot
module micro_sd_slot_cutout()
{    
    cube([microsd_width, microsd_height, microsd_depth]);
}

// Create a cutout for a headphone jack (3.5mm TRS recepticle)
module headphone_cutout()
{
    cylinder(d=headphone_dia, h=wall_thickness);
}

// Create the main body solid from defined corner locations. 
module main_body()
{
    hull()
    {
        for (corner = main_body_corners)
            translate(corner) cylinder(r=main_body_corner_radius, h=base_d);
    }
}

// Apply the port cutouts to the main body solid
module port_cutouts()
{
    // USB-C
    usb_c_loc = [-usb_c_full_width / 2.0 + (total_w / 2.0 - 45.0), total_h / 2.0, base_d / 2.0 - (usb_c_height / 2.0)];
    translate(usb_c_loc) rotate(edge_rotation_deg) usb_c_cutout();
    
    // MicroSD card slot
    microsd_loc = [-microsd_width / 2.0, -total_h / 2.0 + 2.0, base_d / 2.0];
    translate(microsd_loc) rotate(edge_rotation_deg) micro_sd_slot_cutout();

    // 3.5mm headphone jack
    headphone_loc = [screen_w / 2.0 - 30.0, total_h / 2.0, base_d - 8.0];
    translate(headphone_loc) rotate(edge_rotation_deg) headphone_cutout();
}

// Apply cutouts to the left of the screen
module left_wing_cutouts()
{
    // D-Pad
    translate(dpad_loc) dpad_cutout();

    // Analog Stick
    translate(l_analog_loc) joycon_cutout();
    
    // Fn button cluster
    fn_button_loc = [-total_w/2.0 + wing_w/1.5, -35, base_d - wall_thickness];
    translate(fn_button_loc) aux_button_cutouts();
    
    // Home button
    home_button_loc = [-total_w/2.0 + wing_w/1.25, 35.0, base_d - wall_thickness];
    translate(home_button_loc) aux_home_button_cutout();
    
    // Speaker grill
    speaker_loc = [-total_w/2.0 + wing_w/3.5 - 4.0, -35.0, base_d - wall_thickness];
    translate(speaker_loc) speaker_grill();
    
    // Bumper cutout
    shoulder_angle_rotate = edge_rotation_deg + [0.0, 0.0, shoulder_angle_deg];
    translate(left_shoulder_btn_loc) rotate(shoulder_angle_rotate) shouder_button_cutout();
    
    // Trigger cutout]
    translate(left_trigger_loc) cube([trigger_cutout_w, trigger_cutout_h, trigger_cutout_d]);
}

// Apply cutouts to the right of the screen
module right_wing_cutouts()
{
    // Face button cluster
    translate(face_button_loc) face_button_cutouts();
    
    // Analog Stick
    translate(r_analog_loc) joycon_cutout();
    
    // Start/Select button cluser
    start_sel_loc = [total_w/2 - wing_w/1.5, -35, base_d - wall_thickness];
    translate(start_sel_loc) aux_button_cutouts();
    
    // Speaker grill
    speaker_loc = [total_w/2 - wing_w/3.5 - 4, -35, base_d- wall_thickness];
    translate(speaker_loc) speaker_grill();

    // Bumper cutout
    shoulder_angle_rotate = edge_rotation_deg + [0.0, 0.0, -shoulder_angle_deg];
    translate(right_shoulder_btn_loc) rotate(shoulder_angle_rotate) shouder_button_cutout();
    
    // Trigger cutout
    translate(right_trigger_loc) cube([trigger_cutout_w, trigger_cutout_h, trigger_cutout_d]);
}

// Create a cavity inside the main solid body
module main_body_cavity()
{
    // Main cavity
    main_cavity_loc   = [-total_w/2 + wall_thickness, -total_h/2 + wall_thickness, -wall_thickness];
    main_cavity_scale = [(total_w - (2 * wall_thickness)) / total_w, (total_h - (2 * wall_thickness)) / total_h, 1.0];
    translate([0.0, 0.0, -(wall_thickness + 1)]) scale(main_cavity_scale) main_body();
    
    // Left wing additional cavity
    
    left_cavity_loc = [-screen_w/2 - (wing_w-2), -(screen_h + screen_lip_width)/2 + wall_thickness, wall_thickness];
    scale(main_cavity_scale) hull() {
        for (corner = main_body_corners)
        {
            if (corner[0] < 0) translate(corner - [0.0, 0.0, wall_thickness]) cylinder(r=main_body_corner_radius, h=base_d);
        }
        translate([-screen_w/2 - wall_thickness, -total_h/2, -wall_thickness]) cube([1, total_h, base_d]);
    }
    
    right_cavity_loc = [screen_w/2 + (wing_w-2), -(screen_h + screen_lip_width)/2 + wall_thickness, wall_thickness];
    scale(main_cavity_scale) hull() {
        for (corner = main_body_corners)
        {
            if (corner[0] > 0) translate(corner - [0.0, 0.0, wall_thickness]) cylinder(r=main_body_corner_radius, h=base_d);
        }
        translate([screen_w/2 + 1, -total_h/2, -wall_thickness]) cube([1, total_h, base_d]);
    }
}

// Create the main shell before adding mount posts and button retainers
module main_shell()
{
    difference()
    {
        // 1. Main Body Solid
        main_body();
        
        // 2 - Screen Cutout
        screen_cutout();

        // 3 - Left Wing: D-Pad & Analog Stick Cutouts
        left_wing_cutouts();
        
        // 4 - Right Wing: Face Button Cluster Cutouts
        right_wing_cutouts();
        
        // 5 - Port Cutouts
        port_cutouts();

        // 5 - Internal Cavity
        main_body_cavity();
    }
}

module add_mounts()
{
    translate(face_button_loc - [0.0, 0.0, face_btn_ret_d]) face_button_retainers();
    translate(start_sel_loc   - [0.0, 0.0, aux_btn_ret_d])  aux_start_select_button_retainers();
    translate(home_button_loc - [0.0, 0.0, aux_btn_ret_d])  aux_home_button_retainer();
    translate(fn_button_loc   - [0.0, 0.0, aux_btn_ret_d])  aux_fn_menu_button_retainers();
    translate(dpad_loc        - [0.0, 0.0, dpad_ret_d])     dpad_retainer();
    
    translate(mnt_post_1_loc) rotate([180, 0, 0]) mount_post();
    translate(mnt_post_2_loc) rotate([180, 0, 0]) mount_post();
    translate(mnt_post_3_loc) rotate([180, 0, 0]) mount_post();
    translate(mnt_post_4_loc) rotate([180, 0, 0]) mount_post();
    
    //translate() rotate() s_btn_pin_mount(shell=true)
    
    translate(l_analog_loc - [0.0, 0.0, jc_mnt_top_d]) joycon_mount_posts(front=false);
    translate(r_analog_loc - [0.0, 0.0, jc_mnt_top_d]) joycon_mount_posts(front=false);
}

// --- MAIN BODY MODULES ---
/*
Create the main body module
*/

module front_shell()
{
    union()
    {
        main_shell();
        add_mounts();
    }
}

// --- RENDER ---
/*
Actually draw the main shell - In this case, perform a test to make sure the module functions as expected.
*/

// Actually draw the main shell
front_shell();