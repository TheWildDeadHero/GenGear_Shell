// --- INCLUDES ---
/*
All common dimensions are stored in their own SCAD file so that variables are consistent throughout
the multiple files created for this project.
*/
include <Common_Dimensions.scad>
use <Dome.scad>

// --- RENDER RESOLUTION ---
/*
Set the rendering resolution. Lower for lower-power systems.
*/
$fn = 128;

// --- DIMENSIONS ---
/*
Local dimensions that are specific to this drawing
*/
// No local dimensions

// --- FUNCTIONS ---
/*
Functions that make the code more legible and reusable
*/

// Determine the tolerance for the pad interface given the cardinal pad, the symmetric pad, or the square pad
//
function btn_get_pad_tol(dir, sym, tl) = dir == UNDEF ? (sym == UNDEF ? (tl == UNDEF ? UNDEF : tl / 2) : sym / 2) : dir;

// Calculate the pad offset from the center given the distance and tolerance
//
function btn_get_pad_offset(d, tl) = -d / 2 - tl;

// --- MODULES ---
/*
Cutouts and extrusions are all mapped to their own modules to make the model more readable and
reusable.
*/

// Create a button pad given the width, height, depth, and cardinal tolerances
//
module square_button_pad(w, h, d, tol_n, tol_s, tol_e, tol_t)
{
    cube([w + tol_e + tol_t, h + tol_n + tol_s, d]);
}

module circle_button_pad(dia, r=UNDEF, d, keys=[], key_w_deg=UNDEF, key_w_rad=UNDEF, key_r=UNDEF, key_dia=UNDEF, btn_dia=UNDEF)
{
    dia = r == UNDEF ? dia : 2 * r;
    
    key_r = key_r == UNDEF ? (key_dia == UNDEF ? dia / 2 : key_dia / 2) : key_r;
    
    if (len(keys) > 0)
    {
        key_deg = [for (i = [0 : len(keys) - 1]) 
            is_num(key_w_deg) ? key_w_deg : 
            is_num(key_w_rad) ? (key_w_rad * 180 / PI) : 
            is_list(key_w_deg) ? key_w_deg[i] : 
            is_list(key_w_rad) ? (key_w_rad[i] * 180 / PI) : 
            0.0 ];

        for (key = [0:len(keys) - 1])
            // Make sure the keys are centered
            rotate(keys[key] - key_deg[key] / 2) rotate_extrude(angle=key_deg[key]) square([key_r, d]);
    }

    cyl_dia = (key_r * 2 > dia || len(keys) == 0) ? dia : btn_dia;
    
    cylinder(d=cyl_dia, h=d);
}

// --- MAIN BODY MODULES ---
/*
Create the main body module
*/

// Create a button
module button(dia=UNDEF, r=UNDEF, w=UNDEF, h=UNDEF, d,
              deg=UNDEF,
              rad=UNDEF,
              dome_dia=UNDEF,
              dome_r=UNDEF,
              pad_r=UNDEF,
              pad_dia=UNDEF,
              pad_tol=UNDEF,
              pad_tol_h=UNDEF, pad_tol_w=UNDEF,
              pad_tol_n=UNDEF, pad_tol_s=UNDEF, pad_tol_e=UNDEF, pad_tol_t=UNDEF,
              pad_d,
              pad_keys=[], key_w_deg=UNDEF, key_w_rad=UNDEF, key_dia=UNDEF, key_r=UNDEF,
              concavity_offset=-1)
{
    // Determine the shape of the button
    is_flat = (deg == UNDEF || deg == 0.0) && (rad == UNDEF || rad == 0.0) && dome_dia == UNDEF && dome_r == UNDEF;
    is_pill = dia == UNDEF && r == UNDEF;
    
    // Determine the radius based off of the shape
    radius = is_pill ? h / 2 : (r == UNDEF ? dia / 2 : r);
    
    // If not a pill-shaped button, set the width and height as the diameter
    w = is_pill ? w : radius * 2;
    h = is_pill ? h : radius * 2;
    
    // Get the cardinal pad tolerances
    pad_tol_n = btn_get_pad_tol(pad_tol_n, pad_tol_h, pad_tol);
    pad_tol_s = btn_get_pad_tol(pad_tol_s, pad_tol_h, pad_tol);
    pad_tol_e = btn_get_pad_tol(pad_tol_e, pad_tol_w, pad_tol);
    pad_tol_t = btn_get_pad_tol(pad_tol_t, pad_tol_w, pad_tol);
    
    // Determine if there is a pad diameter and if there is, the value
    pad_dia = pad_tol_n == UNDEF ? (pad_r == UNDEF ? pad_dia : pad_r * 2) : UNDEF;
    
    // Get the value to determine the arc of the dome
    sphere_radius = is_flat ? 0.0 : dome_get_sphere_r(radius, dome_dia, dome_r, deg, rad);
    
    // X and Y offsets for the pad
    pad_offset_x = pad_dia == UNDEF ? btn_get_pad_offset(w, pad_tol_t) : -radius - (pad_dia / 2);
    pad_offset_y = pad_dia == UNDEF ? btn_get_pad_offset(h, pad_tol_s) : -radius - (pad_dia / 2);
    
    // Get the height before adding a convex dome
    actual_d = (concavity_offset >= 0 && sphere_radius > 0) || sphere_radius ==  0 ? d : d - dome_get_d(r=radius, sr=sphere_radius);

    // If the button is not circular, create a pill-shaped dome
    if (is_pill)
    {
        west_cyl_x_offset = -(w / 2 - h / 2);
        east_cyl_x_offset = west_cyl_x_offset * -1;

        union()
        {
            difference()
            {
                // Create the main body
                linear_extrude(actual_d) hull()
                {
                    translate([west_cyl_x_offset, 0.0]) circle(r=radius);
                    translate([east_cyl_x_offset, 0.0]) circle(r=radius);
                }
        
                // Create the concave dome if a concavity offset exists and a sphere radius exists
                if (concavity_offset >= 0 && sphere_radius > 0)
                {
                    concavity_radius = radius - concavity_offset;

                    hull()
                    {
                        rotate([180.0, 0.0, 0.0]) translate([west_cyl_x_offset, 0.0, -d]) dome(r=concavity_radius, sphere_r=sphere_radius);
                        rotate([180.0, 0.0, 0.0]) translate([east_cyl_x_offset, 0.0, -d]) dome(r=concavity_radius, sphere_r=sphere_radius);
                    }
                }
            }
            
            // Create the convex dome if no concavity offset and a sphere radius exists
            if (concavity_offset < 0 && sphere_radius > 0)
            {
                hull()
                {
                    translate([west_cyl_x_offset, 0.0, actual_d]) dome(r=radius, sphere_r=sphere_radius);
                    translate([east_cyl_x_offset, 0.0, actual_d]) dome(r=radius, sphere_r=sphere_radius);
                }
            }
                
            // Create the button "pad" that interfaces with the button
            translate([pad_offset_x, pad_offset_y, -pad_d]) square_button_pad(w, h, pad_d, pad_tol_n, pad_tol_s, pad_tol_e, pad_tol_t);
        }
    }
    else
    {
        // Create a circular button

        union()
        {
            difference()
            {
                // Create the main cylinder
                cylinder(r=radius, h=actual_d);
                        
                // Create the concave dome if a concavity offset exists and a sphere radius exists
                if (concavity_offset >= 0 && sphere_radius > 0)
                    rotate([180.0, 0.0, 0.0]) translate([0.0, 0.0, -d]) dome(r = radius - concavity_offset, sphere_r = sphere_radius);
            }
            // Create the convex dome if no concavity offset and a sphere radius exists
            if (concavity_offset < 0 && sphere_radius > 0)
                    translate([0.0, 0.0, actual_d]) dome(r=radius, sphere_r=sphere_radius);

            // If the pad diameter is defined, create a round button pad
            /*
            keys=[], key_w_deg=UNDEF, key_w_rad=UNDEF
            */
            if (pad_dia != UNDEF) translate([0.0, 0.0, -pad_d]) circle_button_pad(dia=pad_dia, d=pad_d, keys=pad_keys, key_w_deg=key_w_deg, key_w_rad=key_w_rad, key_dia=key_dia, key_r=key_r, btn_dia=radius * 2);
                    
            // Else, create a square pad
            else translate([pad_offset_x, pad_offset_y, -pad_d]) square_button_pad(w = 2 * radius, h = 2 * radius, d = pad_d, tol_n = pad_tol_n, tol_s = pad_tol_s, tol_e = pad_tol_e, tol_t = pad_tol_t);
        }
    }
}

// Create retaining posts for buttons
module square_button_retainer(w, h, d,
                       w_dist, h_dist,
                       north=true, south=true, east=true, west=true)
{
    union()
    {
        if (north) translate([-w / 2.0,  h_dist / 2.0    ,  0.0]) cube([w, h, d]);
        if (south) translate([-w / 2.0, -h_dist / 2.0 - h,  0.0]) cube([w, h, d]);
        if (east)  translate([  w_dist / 2.0,     -w / 2.0, 0.0]) cube([h, w, d]);
        if (west)  translate([ -w_dist / 2.0 - h, -w / 2.0, 0.0]) cube([h, w, d]);
    }
}

// Create a circle button retainer. Add key cutouts if provided.
module circle_button_retainer(dia=UNDEF, r=UNDEF, d, thickness=UNDEF, keys=[], key_w_deg=UNDEF, key_w_rad=UNDEF, key_r=UNDEF, key_dia=UNDEF)
{
    outer_dia = (dia == UNDEF ? r * 2 : dia) + 2 * thickness;
    inner_dia = (dia == UNDEF ? r * 2 : dia);
    
    key_dia = len(keys) > 0 ? outer_dia : UNDEF;

    difference()
    {
        circle_button_pad(dia = outer_dia, d = d);

        circle_button_pad(dia = inner_dia, d = d + 0.01, keys = keys, key_w_deg = key_w_deg, key_w_rad = key_w_rad, key_dia = key_dia + 0.01); 
    }
}

// --- RENDER ---
/*
Actually draw the main shell
*/
// Nothing to render