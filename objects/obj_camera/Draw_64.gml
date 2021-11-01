draw_sprite_ext(spr_gun, gun_frame, view_get_wport(0) / 2, view_get_hport(0), 4, 4, 0, c_white, 0.7);

var here_z = -tilemap_get_at_pixel(heightmap, x, y) * HEIGHTMAP_MULTIPLIER;
draw_text(2, 2, string(z - MAX_JUMP < here_z || z < here_z));