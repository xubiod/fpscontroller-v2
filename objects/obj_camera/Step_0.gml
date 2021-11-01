window_set_cursor(capture ? cr_none : cr_default);

if (capture) {
	var center_x = view_get_wport(0) / 2;
	var center_y = view_get_hport(0) / 2;
	
	var delta_x = window_mouse_get_x() - center_x;
	var delta_y = window_mouse_get_y() - center_y;
	
	xrot += delta_y * SENSITIVITY;
	yrot += delta_x * SENSITIVITY;
	
	window_mouse_set(center_x, center_y);
	
	var move_x = lengthdir_x(-SPEED * MOVE_VERTICAL, yrot + 90) + lengthdir_x(-SPEED * MOVE_HORIZONTAL, yrot);
	var move_y = lengthdir_y(-SPEED * MOVE_VERTICAL, yrot + 90) + lengthdir_y(-SPEED * MOVE_HORIZONTAL, yrot);
	
	zrot = smooth_approach(zrot, (-SPEED * MOVE_HORIZONTAL) / SENSITIVITY, 0.1);
	
	if (z == min_z && KEY_JUMP) {
		zspd -= jump_strength;
	}
	
	xspd += move_x;
	yspd += move_y;
}

// var current_z = -tilemap_get_at_pixel(heightmap, x, y) * HEIGHTMAP_MULTIPLIER;
var future_z = -tilemap_get_at_pixel(heightmap, x + xspd, y + yspd) * HEIGHTMAP_MULTIPLIER;

if (z - MAX_JUMP < future_z || z < future_z) {
	min_z = future_z;
} else {
	//var _tile_left = tilemap_get_cell_x_at_pixel(heightmap, x + xspd, y + yspd) * heightmap_tile_width;
	//var _tile_top = tilemap_get_cell_y_at_pixel(heightmap, x + xspd, y + yspd) * heightmap_tile_height;
	//var _tile_right = _tile_left + heightmap_tile_width;
	//var _tile_bottom = _tile_top + heightmap_tile_height;

	var bbox_side;
	
	if (xspd > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
	if	(tilemap_get_at_pixel(heightmap, bbox_side + xspd, bbox_top) != 0) ||
		(tilemap_get_at_pixel(heightmap, bbox_side + xspd, bbox_bottom) != 0) {
		
		if (xspd > 0) x = x - (x % heightmap_tile_width) + (heightmap_tile_width - 1) - (bbox_right - x);
		else x = x - (x % heightmap_tile_width) - (bbox_left - x);
		xspd *= -1;
	}
	
	if (yspd > 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
	if	(tilemap_get_at_pixel(heightmap, bbox_left, bbox_side + yspd) != 0) ||
		(tilemap_get_at_pixel(heightmap, bbox_right, bbox_side + yspd) != 0) {
		
		if (yspd > 0) y = y - (y % heightmap_tile_height) + (heightmap_tile_height - 1) - (bbox_bottom - y);
		else y = y - (y % heightmap_tile_height) - (bbox_top - y);
		yspd *= -1;
	}
}

zspd += zgravity;

xspd *= xfriction;
yspd *= yfriction;
zspd *= zfriction;

x += xspd;
y += yspd;
z += zspd;

if (z > min_z) {
	z = min_z;
	zspd = 0;
}

xrot %= 360;
yrot %= 360;
zrot %= 360;

xrot_temp = smooth_approach(xrot_temp, 0, 0.5);
yrot_temp = smooth_approach(yrot_temp, 0, 0.5);
zrot_temp = smooth_approach(zrot_temp, 0, 0.5);

xrot = clamp(xrot, xrot_capmin, xrot_capmax);

var matrix = matrix_build_lookat(x, y, z + z_offset, x, y - 128, z + z_offset, 0, 0, -1);
matrix = matrix_multiply(matrix, matrix_build(0, 0, 0, xrot + xrot_temp, yrot + yrot_temp, zrot + zrot_temp, 1, 1, 1));
camera_set_view_mat(view_camera[0], matrix);

cooldown = max(0, cooldown - 1);

if (gun_frame > 0) gun_frame++;
if (gun_frame > sprite_get_number(spr_gun)) gun_frame = 0;