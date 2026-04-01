// --- GENERIC COMMON VARS ---
// Common input cutout sizes
edge_rotation_deg                   = [90, 0, 0];

wall_thickness                      = 2.0;

UNDEF                               = "undef";

// --- SCREEN DIMENSIONS ---
screen_w                            = 84.5 ;
screen_h                            = screen_w;             // The display is square and the dimensions are equal
screen_glass_d                      = 1.25;
screen_panel_d                      = 2.0;
screen_t_post_offset                = 19.5;
screen_b_post_offset                = 15.75;
screen_post_d                       = 6.0;
screen_post_pad                     = 1.0;
screen_lip_width                    = 4.0;
screen_bezel_top                    = 2.0;
screen_bezel_bottom                 = screen_bezel_top;

// Screen control panel
screen_btn_w                        = 4.0;
screen_btn_d                        = 44.5;

// --- JOYCON ANALOG MODULE DIMENSIONS ---

jc_w                                = 17.0;
jc_h                                = 18.4;
jc_d                                = 5.0;

jc_pole_r                           = 1.5;
jc_pole_dome_r                      = 4.0;
jc_pole_dome_sr                     = 4.5;

jc_center_x                         = -7.75;
jc_center_y                         = -9.2;

jc_mnt_dia                          = 3.8;
jc_mnt_d                            = 1.25;
jc_mnt_wall                         = 1.7;
jc_mnt_bore_dia                     = 1.6;

jc_mnt_z_offset                     = 1.0;
jc_mnt_sw_offset                    = 0.1;
jc_mnt_ne_offset                    = 0.3;
jc_mnt_top_d                        = 2.75;
jc_mnt_btm_d                        = 1.0;

jc_ctr_offset_x                     = -jc_w / 2 - jc_center_x;
jc_ctr_offset_y                     = -jc_h / 2 - jc_center_y;

jc_hat_edge_dia                     = 2.5;
jc_hat_slice_d                      = 0.0000001;
jc_hat_dia                          = 15.0;
jc_hat_dome_dia                     = 11;
jc_hat_dome_d                       = 0.25;
jc_hat_dome_deg                     = 20.0;

jc_hat_total_d                      = 10.0;

jc_ne_loc                           = [ (jc_w + jc_center_x) - jc_mnt_dia / 2 - jc_mnt_ne_offset,
                                        (jc_h + jc_center_y) + jc_mnt_wall,
                                        jc_mnt_z_offset ];
jc_sw_loc                           = [ jc_center_x - jc_mnt_wall,
                                        -(jc_h + jc_center_y) + jc_mnt_dia / 2 + jc_mnt_sw_offset,
                                        jc_mnt_z_offset];

jc_cutout_dia                       = 13.0;
jc_cutout_d                         = wall_thickness * 2;

// --- KAILH BLUE MICROSWITCHE DIMENSIONS ---

kailh_sw_w                          = 12.75;
kailh_sw_h                          = 5.75;
kailh_sw_d                          = 6.6;

kailh_sw_pin_dist                   = 5.0;
kailh_sw_pin_pitch                  = 1.0;
kailh_sw_pin_length                 = 3.0;

// --- OMRON D2LS MICROSWITCH DIMENSIONS ---

omron_d2ls_w                        = 8.6;
omron_d2ls_h                        = 4.95;
omron_d2ls_d                        = 3.0;

omron_d2ls_plunger_dia              = 1.0;
omron_d2ls_plunger_w                = 1.7;
omron_d2ls_plunger_offset           = 3.61;

omron_d2ls_boss_dia                 = 1.05;
omron_d2ls_boss_d                   = 0.6;
omron_d2ls_boss_dist                = 4.0;

// --- DPAD DIMENSIONS ---

// Main Dimensions
dpad_dia                            = 26.2;
dpad_d                              = 6.75;

// Width of the cardinal direction "arms"
dpad_dir_w                          = 7.25;

// Contour dimensions. The scphere diameter to create the angle and the depth offset
dpad_contour_dia                    = 89.445;
dpad_contour_d_offset               = 48.225;

// Dimensions of the indent at the center of the DPad
dpad_ctr_indent_dia                 = dpad_dir_w;   // Just make this as wide as the direction extrudes
dpad_ctr_d_offset                   = dpad_d / 2 + 1.0;

// Cutout dimensions for the main housing
dpad_cutout_dia                     = 29.3;
dpad_cutout_d                       = wall_thickness * 2;

// Dimensions for the interface pad
dpad_pad_d                          = 1.25;
dpad_pad_dia                        = dpad_cutout_dia + 1.5;
dpad_pad_key_w                      = dpad_dir_w;
dpad_pad_key_h                      = dpad_dir_w;
dpad_pad_key                        = 1.25;

// Retention body dimensions
dpad_ret_offset                     = 0.75; // Give the DPad some room to move
dpad_ret_thickness                  = 0.75;
dpad_ret_dia                        = dpad_pad_dia + dpad_ret_offset;
dpad_ret_d                          = dpad_pad_d;

// Pivot dimensions
dpad_pivot_dia                      = 3.0;
dpad_pivot_d                        = kailh_sw_d;

// --- FACE BUTTON DIMENSIONS ---

// General face button dimensions
face_btn_dia                        = 9.6;
face_btn_d                          = 5.1;

// Face button text dimensions
face_btn_txt_offset                 = 4.9;
face_btn_txt_size                   = 4.0;
face_btn_txt_d                      = 1.0;
face_btn_txt_halign                 = "center";
face_btn_txt_valign                 = "center";

// Greater sphere diameter for the face button dome
face_btn_dome_dia                   = 18.0;

// Measured face button cutout diameter
face_btn_cutout_dia                 = 10.2;
face_btn_cutout_d                   = wall_thickness * 2;

// Face button pad measurements
face_btn_pad_tol                    = 1.0;
face_btn_pad_dia                    = (face_btn_cutout_dia + face_btn_pad_tol);
face_btn_pad_d                      = 1.25;

// X, Y, and Z button offsets
xyz_btn_offset                      = [-8.0, 12.0, 0.0];

// Face button coordinates (Main A, B, and C buttons)
face_btn_coordinates                = [ [-11.0, -8.0, 0.0],   // A
                                        [  0.0,  0.0, 0.0],   // B
                                        [ 13.5,  3.0, 0.0] ]; // C

// Button retainer measurements                                 
face_btn_ret_thickness              = 0.75;
face_btn_ret_dia                    = face_btn_cutout_dia;
face_btn_ret_d                      = face_btn_pad_d;

// Face button key locations
face_btn_a_keys                     = [90, 15, 270];
face_btn_b_keys                     = [90, 33, 270];
face_btn_c_keys                     = [90, 50, 270];
face_btn_x_keys                     = [90, 180, 270];
face_btn_y_keys                     = [90, 143, 270];
face_btn_z_keys                     = [90, 155, 270];

// Face button key width (as an arc in degrees)
face_btn_key_deg                    = 25.0;
face_btn_key_deg_tol                = 1.5;

// --- SHOULDER BUTTON DIMENSIONS ---

// Main button dimensions
s_btn_w                             = 29.3;
s_btn_h                             = 8.4;
s_btn_d                             = 5.75;

// Button pad dimensions
s_btn_pad_tol                       = 1.0;
s_btn_pad_tol_n                     = 0.25;
s_btn_pad_tol_s                     = 0.25;
s_btn_pad_tol_e                     = 0.5;
s_btn_pad_tol_t                     = 2.0;
s_btn_pad_d                         = 1.25;

// Button dome greater sphere diameter
s_btn_dome_dia                      = 14.0;

// Man cutout dimensions
s_btn_cutout_w                      = 30.5;
s_btn_cutout_h                      = 9.6;
s_btn_cutout_d                      = wall_thickness * 6;

// Mounting dimensions
s_btn_mnt_dia                       = 2.5;
s_btn_mnt_d                         = s_btn_h + s_btn_pad_tol_n + s_btn_pad_tol_s;
s_btn_pin_dia                       = 1.2;
s_btn_spring                        = 2.5;

// --- AUXILLARY BUTTON DIMENSIONS ---

// General auxillary button dimensions
aux_btn_dia                         = 5.3;
aux_btn_d                           = 4.0;

// Greater sphere diameter for the auxillary button dome
aux_btn_dome_dia                    = 12.0;

// Measured auxillary button cutout diameter
aux_btn_cutout_dia                  = 5.6;
aux_btn_cutout_d                    = wall_thickness * 2;

// Auxillary button pad measurements
aux_btn_pad_tol                     = 1.0;
aux_btn_pad_dia                     = (aux_btn_cutout_dia + aux_btn_pad_tol);
aux_btn_pad_d                       = 1.25;

// Auxillary button cluster relative distance
// The size of the buttons happens to be an excellent distance between, so just use that
aux_btn_dist                        = 2 * aux_btn_cutout_dia;

// Auxillary button retainer measurements                                 
aux_btn_ret_thickness               = 0.75;
aux_btn_ret_dia                     = aux_btn_cutout_dia;
aux_btn_ret_d                       = aux_btn_pad_d;

// Auxillary button key locations
aux_btn_menu_keys                   = [90, 20, 270];
aux_btn_fn_keys                     = [90, 44, 270];
aux_btn_start_keys                  = [90, 131, 270];
aux_btn_select_keys                 = [90, 225, 270];
aux_btn_home_keys                   = [90, 146, 270];

// Auxillary button key width (as an arc in degrees)
aux_btn_key_deg                     = 20.0;
aux_btn_key_deg_tol                 = 1.25;

// --- MAIN BODY DIMENSIONS ---
wing_w                              = 49.0;
total_w                             = screen_w + (wing_w * 2.0);
total_h                             = screen_h + screen_bezel_top + screen_bezel_bottom;
base_d                              = 22.0;
recess_depth                        = 1.5;

main_body_corners                   = [ [-total_w / 2 +  4.0, -(screen_h + screen_lip_width) / 2 + 22.0, 0.0],     // Lower-left  (upper)
                                        [ total_w / 2 -  4.0, -(screen_h + screen_lip_width) / 2 + 22.0, 0.0],     // Lower-right (upper)
                                        [-total_w / 2 + 12.0, -(screen_h + screen_lip_width) / 2 +  4.0, 0.0],     // Lower-left
                                        [ total_w / 2 - 12.0, -(screen_h + screen_lip_width) / 2 +  4.0, 0.0],     // Lower-right

                                        [ total_w / 2 - 36.0,  (screen_h + screen_lip_width) / 2 -  4.0, 0.0],     // Upper-right (upper)
                                        [ total_w / 2 -  4.0,  (screen_h + screen_lip_width) / 2 - 14.0, 0.0],     // Upper-right (lower)
                                        [-total_w / 2 + 36.0,  (screen_h + screen_lip_width) / 2 -  4.0, 0.0],     // Upper-left (upper)
                                        [-total_w / 2 +  4.0,  (screen_h + screen_lip_width) / 2 - 14.0, 0.0], ];  // Upper-left (lower)
                      
main_body_corner_radius             = 4.0;

// Get the angle of the shoulders for shoulder button/analog trigger placement
shoulder_width                      = (total_w / 2 - 4.0) - (total_w / 2 - 36.0);
shoulder_height                     = ((screen_h + screen_lip_width) / 2 - 4.0) - ((screen_h + screen_lip_width) / 2 - 14.0);
shoulder_angle_deg                  = atan(shoulder_height / shoulder_width);
shoulder_length                     = shoulder_width / cos(shoulder_angle_deg);

// Trigger dimensions
trigger_cutout_w                    = shoulder_width + 32.0;
trigger_cutout_h                    = 21.0;
trigger_cutout_d                    = 10.0;

// For the left side, just make the X points negative.
shoulder_loc_upper                  = [ total_w / 2 - 36.0,  (screen_h + screen_lip_width) / 2 -  4.0, 0];
shoulder_loc_lower                  = [ total_w / 2 - 4.0,   (screen_h + screen_lip_width) / 2 - 14.0, 0];

// USB-C recepticle dimensions
usb_c_height                        = 3.41;
usb_c_full_width                    = 9.09;
usb_c_depth                         = 10.1;
usb_c_width                         = usb_c_full_width - usb_c_height;

// 3.5mm recepticle dimensions
headphone_dia                       = 5.8;

// MicroSD card slot dimensions
microsd_width                       = 11.15;     // Add 0.15 for tolerance
microsd_height                      = 1.15;
microsd_depth                       = 15.15;

// Locations for face modules
face_button_loc                     = [ total_w / 2 - wing_w / 2 + 2.5,  12.0, base_d - wall_thickness];
start_sel_loc                       = [ total_w / 2 - wing_w / 1.5,     -35.0, base_d - wall_thickness];
home_button_loc                     = [-total_w / 2 + wing_w / 1.25,     35.0, base_d - wall_thickness];
fn_button_loc                       = [-total_w / 2 + wing_w / 1.5,     -35.0, base_d - wall_thickness];
dpad_loc                            = [-total_w / 2 + wing_w / 2,        15.0, base_d - wall_thickness];
l_analog_loc                        = [-total_w / 2 + wing_w/1.5,       -18.0, base_d - wall_thickness];
r_analog_loc                        = [ total_w / 2 - wing_w/1.5,       -18.0, base_d - wall_thickness];

// Shoulder and trigger locations
left_shoulder_btn_loc               = [-((shoulder_loc_upper[0] + shoulder_loc_lower[0]) / 2), total_h / 2, trigger_cutout_d + s_btn_h / 2];
right_shoulder_btn_loc              = [  (shoulder_loc_upper[0] + shoulder_loc_lower[0]) / 2,  total_h / 2, trigger_cutout_d + s_btn_h / 2];

right_trigger_loc                   = [ (shoulder_loc_lower[0] - shoulder_width), total_h / 2 - 2 * shoulder_height, 0];
left_trigger_loc                    = [-(shoulder_loc_lower[0] + shoulder_width), total_h / 2 - 2 * shoulder_height, 0];

// Mount post dimensions and locations
mnt_outer_dia                       = 5.5;
mnt_outer_d                         = 11.5;
mnt_inner_dia                       = 2.5;
mnt_inner_d                         = 8.0;

mnt_post_1_loc                      = [-(screen_w / 2 + mnt_outer_dia / 2),
                                       -(total_h / 2 - wall_thickness - mnt_outer_dia / 2 - 1),
                                       base_d - wall_thickness];
mnt_post_2_loc                      = [ (screen_w / 2 + mnt_outer_dia / 2),
                                       -(total_h / 2 - wall_thickness - mnt_outer_dia / 2 - 1),
                                       base_d - wall_thickness];
mnt_post_3_loc                      = [-(total_w / 2 - wall_thickness - mnt_outer_dia / 2),
                                      0.0,
                                      base_d - wall_thickness];
mnt_post_4_loc                      = [(total_w / 2 - wall_thickness - mnt_outer_dia / 2),
                                      0.0,
                                      base_d - wall_thickness];
                                      
// Speaker grill
spk_grill_height                    = 14.0;
spk_grill_width                     = 8.0;
spk_grill_grid_spacing              = 2.0;
spk_grill_hole_dia                  = 1.0;

// --- INNER FRAME / PCB DIMENSIONS

// Make the inner frame 99.9999% the size of the internal cavity to ensure a tight, but decent fit
scale_fit_ratio                     = 0.999999;
frame_scale                         = [((total_w - (2 * wall_thickness)) / total_w) * scale_fit_ratio,
                                       ((total_h - (2 * wall_thickness)) / total_h) * scale_fit_ratio];
frame_thickness                     = 1.625;

screen_post_outer_dia               = 5.5;
screen_post_inner_dia               = 2.5;
screen_mount_offset                 = 23.0;

mount_hole_dia                      = 2.75;
mount_hole_y_offset                 = 19.3;
mount_hole_x_offset_left            = 20.75;
mount_hole_x_offset_right           = -1.0;

sbc_cutout_w                        = 68.0;
sbc_cutout_h                        = screen_h - screen_mount_offset;
sbc_cutout_offset                   = [-screen_w / 2 + (mount_hole_x_offset_left - 0.25 - screen_post_outer_dia / 2), -screen_h / 2];

hdmi_cutout_w                       = 18.5;
hdmi_cutout_h                       = 16.0;
hdmi_w_offset                       = 60.0 - hdmi_cutout_w;
hdmi_cutout_offset                  = [-screen_w / 2 + hdmi_w_offset + 2, screen_h / 2 - hdmi_cutout_h];

kailh_sw_plunger_r                  = 0.5;

// --- MOUNT DIMENSIONS ---

pcb_mnt_dia                         = 5.5;
pcb_mnt_d                           = 11.5;
pcb_mnt_bore_dia                    = 2.5;
pcb_mnt_bore_d                      = 8.0;