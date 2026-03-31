// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Dome.scad>
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
// Get the total height of the joystick hat
function joycon_get_hat_d() = let(dome_d = jc_hat_edge_dia + jc_hat_slice_d) dome_d + (dome_get_d(dia = jc_hat_dome_dia, deg = jc_hat_dome_deg) - jc_hat_dome_d);

// Get the translated (if applicable) 3D coordinates for a given mount post
function joycon_get_mnt_loc(location, front) = front ? [location[0], location[1] * -1, 0.0] : [location[0], location[1], 0];

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/

// Create a singular Joycon mount on the main solid
module joycon_mount(wall=true, d=jc_mnt_d)
{
    difference()
    {
        // Create the main body
        union()
        {
            cylinder(d=jc_mnt_dia, h=d);
            
            if (wall) translate([-jc_mnt_dia /  2, 0, 0]) cube([jc_mnt_dia, jc_mnt_wall, d]);
        }

        // Cutout the bore
        cylinder(d=jc_mnt_bore_dia, h=d);
        
        // Cut off excess from the cylinder
        translate([-jc_mnt_dia / 2, jc_mnt_wall, 0]) cube([jc_mnt_dia, jc_mnt_dia / 2 - jc_mnt_wall, d]);
    }
}

// Create a Joycon hat
module joycon_hat()
{
    dome_z_offset = (jc_hat_edge_dia + jc_hat_slice_d) / 2 - jc_hat_dome_d;

    union()
    {
        difference()
        {
            minkowski()
            {
                // Make the cylinder depth as small as possible
                cylinder(d = jc_hat_dia - jc_hat_edge_dia, h = jc_hat_slice_d, center = true);
                sphere(d = jc_hat_edge_dia);
            }
            
            // Create a little indent for the dome
            translate([0, 0, dome_z_offset]) cylinder(d=jc_hat_dome_dia, h=jc_hat_dome_d);
        }
        
        // Create the dome
        translate([0, 0, dome_z_offset]) dome(dia=jc_hat_dome_dia, angle_deg=jc_hat_dome_deg);
    }
}

// --- MAIN BODY MODULES ---
/*
Create the main body modules
*/

// Create two mount posts for a single Joycon module. Can create either front or rear mounts.
module joycon_mount_posts(front=true, d_offset=0.0)
{
    d = (front ? jc_mnt_top_d : jc_mnt_btm_d + d_offset);
    
    jc_ne_loc = joycon_get_mnt_loc(jc_ne_loc, front);
    jc_sw_loc = joycon_get_mnt_loc(jc_sw_loc, front);
    
    sw_rot_angle = front ? [0.0, 0.0, 180.0] : [0.0, 0.0, 270.0];
    ne_rot_angle = front ? [0.0, 0.0, 90.0] : [0.0, 0.0, 180.0];

    union()
    {
        // Add the south-west mount
        translate(jc_sw_loc) rotate(sw_rot_angle) joycon_mount(wall=false, d=jc_mnt_top_d);
        
        // Add the north-east mount
        translate(jc_ne_loc) rotate(ne_rot_angle) joycon_mount(wall=false, d=jc_mnt_top_d);
    }
}

// Create a rough Joycon solid
module joycon_analog_module()
{
    hat_height = joycon_get_hat_d();

    w_offset = -jc_w / 2.0;

    union()
    {
        // Create the main body
        translate([jc_center_x, jc_center_y, 0.0]) cube([jc_w, jc_h, jc_d]);
        
        // Add the south-west mount
        translate(jc_sw_loc) rotate([0.0, 0.0, 270.0]) joycon_mount();
        
        // Add the north-east mount
        translate(jc_ne_loc) rotate([0.0, 0.0, 180.0]) joycon_mount();
        
        // Add the dome the main post appears out of
        translate([0.0, 0.0, jc_d]) dome(r=jc_pole_dome_r, sphere_r=jc_pole_dome_sr);
        
        // Add the main post
        translate([0.0, 0.0, jc_d]) cylinder(r=jc_pole_r, h=10 - hat_height);
        
        // Add the hat
        translate([0.0, 0.0, jc_d + jc_hat_total_d - (jc_hat_edge_dia + jc_hat_slice_d)]) joycon_hat();
    }
}

module joycon_cutout()
{
    cylinder(d=jc_cutout_dia, h=jc_cutout_d);
}

// --- RENDER ---
/*
Actually draw the main shell - Create a Joycon solid as well as some mounts to attach it to.
*/
joycon_analog_module();