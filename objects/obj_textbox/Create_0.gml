depth = -1000000;

// Textbox Parameters
textbox_width = (64 * 3.25);
textbox_height = (64 * 1.125);
border = 12;
line_sep = 12;
line_width = textbox_width - border*2;
txtb_spr[0] = spr_menu;
txtb_img = 0;
txtb_img_spd = 5 / 60;

// Text
page = 0;
page_number = 0;
text[0] = "";
text_length[0] = string_length(text[0]);
char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;
draw_char = 0;
text_speed = 1;
// Options
option_spr = spr_dialogueoption;
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;
arrow_spd = 1 / 60;

setup = false;


// Text Effects
scr_set_defaults_for_text();
last_free_space = 0;