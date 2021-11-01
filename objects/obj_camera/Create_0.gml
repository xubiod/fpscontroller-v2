var matrix = matrix_build_projection_perspective_fov(-90, -view_get_wport(0)/view_get_hport(0), 2, 32000);
camera_set_proj_mat(view_camera[0], matrix);

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
layer_force_draw_depth(true, 0);

min_z = 0;
z = -400;
z_offset = -40;

xrot = 0;
yrot = 0;
zrot = 0;

xspd = 0;
yspd = 0;
zspd = 0;

xfriction = 0.7;
yfriction = 0.7;
zfriction = 1;

zgravity = 0.6;

xrot_capmin = -90;
xrot_capmax = 90;

xrot_temp = 0;
yrot_temp = 0;
zrot_temp = 0;

jump_strength = 10;

capture = false;
held_frames = 0;

heightmap = layer_tilemap_get_id(layer_get_id("Heightmap"));

heightmap_tile_width = tilemap_get_tile_width(heightmap);
heightmap_tile_height = tilemap_get_tile_width(heightmap);

shoot_on = 5;
cooldown = 0;
gun_frame = 0;