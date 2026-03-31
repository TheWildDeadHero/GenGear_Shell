/// Upgraded pin mount module
module pin_mount(dia=UNDEF, r=UNDEF, d=UNDEF,
                 bore_dia=UNDEF, bore_r=UNDEF,
                 spring_spacing=UNDEF,
                 wall=UNDEF,
                 ns_wall=UNDEF, ew_wall=UNDEF,
                 n_wall=UNDEF, s_wall=UNDEF, e_wall=UNDEF, w_wall=UNDEF,
                 top=false,
                 tolerance=0.01
                 ne_corner=true, se_corner=true, sw_corner=false, nw_corner=false)
{
    // Determine the main body diameter
    dia             = r == UNDEF ? dia : r * 2;
    
    // Determine the bore diameter
    bore_dia        = bore_r == UNDEF ? bore_dia : bore_r * 2;
    
    // Determine spacing dimensions. If undefined, assume 0.
    wall_spacing    = wall_spacing == UNDEF ? 0.0 : wall_spacing;
    spring_spacing  = spring_spacing == UNDEF ? 0.0 : spring_spacing;
    
    // Determine corner dimensions
    set_n_wall      = n_wall != UNDEF || ns_wall != UNDEF || wall != UNDEF;
    set_s_wall      = s_wall != UNDEF || ns_wall != UNDEF || wall != UNDEF;
    set_e_wall      = e_wall != UNDEF || ew_wall != UNDEF || wall != UNDEF;
    set_w_wall      = w_wall != UNDEF || ew_wall != UNDEF || wall != UNDEF;

    n_wall          = mnt_get_wall(n_wall, ns_wall, wall);
    s_wall          = mnt_get_wall(s_wall, ns_wall, wall);
    e_wall          = mnt_get_wall(e_wall, ew_wall, wall);
    w_wall          = mnt_get_wall(w_wall, ew_wall, wall);
    
    // Get the measurements for the mount
    total_w         = dia + wall_spacing;
    offset_w        = total_w - dia / 2;
    total_h         = dia;
    
    // Pre-calculate offsets
    body_offset_x   = -total_w / 2.0 + dia / 2.0;
    body_offset_y   = -dia / 2.0;
    
    // Calculate the height of each slice (before applying tolerance)
    slice_height = (d - spring_spacing) / 4.0;

    difference()
    {
        union()
        {
            // If the pin mount only needs a single corner, divide the length by the subtracting cube by 2 and adjust the position accordingly.
            divisor = single_corner ? 2 : 1;

            translate([body_offset_x, 0.0, 0.0]) cylinder(d=dia, h=d);
            
            north_offset = ;
            south_offset = ;
            east_offset  = ;
            west_offset  = ;
            
            if (set_n_wall && set_e_wall) translate([body_offset_x, body_offset_y, 0.0]) cube([e_wall + dia / 2.0, dia / divisor, d]);
            if (set_s_wall && set_e_wall) translate([body_offset_x, body_offset_y, 0.0]) cube([wall_spacing + dia / 2.0, dia / divisor, d]);
            if (set_n_wall && set_w_wall) translate([body_offset_x, body_offset_y, 0.0]) cube([e_wall + dia / 2.0, dia / divisor, d]);
            if (set_s_wall && set_w_wall) translate([body_offset_x, body_offset_y, 0.0]) cube([wall_spacing + dia / 2.0, dia / divisor, d]);
        }
        
        translate([body_offset_x, 0.0, 0.0]) cylinder(d=bore_dia, h=d);
        
        if (top)
        {
            translate([-total_w / 2, -total_h / 2,                0.0])                                  cube([dia, dia, slice_height - tolerance / 2]);
            translate([-total_w / 2, -total_h / 2, slice_height * 2.0])                                  cube([dia, dia, slice_height + spring_spacing - tolerance / 2]);
        }
        else
        {
            translate([-total_w / 2, -total_h / 2, slice_height + tolerance / 2])                        cube([dia, dia, slice_height - tolerance / 2]);
            translate([-total_w / 2, -total_h / 2, slice_height * 2.0])                                  cube([dia, dia, spring_spacing]);
            translate([-total_w / 2, -total_h / 2, slice_height * 3.0 + spring_spacing + tolerance / 2]) cube([dia, dia, spring_spacing + slice_height - tolerance / 2]);
        }
    }
}