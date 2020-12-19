/// @description Draw button

// Draw base button
draw_self();

// Draw text
draw_set_font(fnt_roboto_demo);
draw_set_color(c_white)
draw_set_halign(fa_center);
draw_set_valign(fa_center);

var draw_string_final = draw_str;

if(show_is_loaded)
{
	if(clickfunction == "rewarded") {
		if(cont_admob.rewarded_loaded) {
			draw_string_final = draw_string_final + " (ready)";
		}
		else {
			draw_string_final = draw_string_final + " (not ready)";
		}
	}
	else {
		if(cont_admob.interstitial_loaded) {
			draw_string_final = draw_string_final + " (ready)";
		}
		else {
			draw_string_final = draw_string_final + " (not ready)";
		}
	}
}

draw_text(x, y, draw_string_final);