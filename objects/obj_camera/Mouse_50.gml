held_frames++;

if (!capture || ((held_frames % shoot_on) != 1) || cooldown > 0) exit;
gun_frame = 1;
cooldown = shoot_on;

xrot_temp -= random_range(10, 17);
yrot_temp += random_range(-8, 8);

var test_line_x = lengthdir_x(HITSCAN_LENGTH, yrot + yrot_temp + 90);
var test_line_y = lengthdir_y(HITSCAN_LENGTH, yrot + yrot_temp + 90);

var hit = ds_list_create();

collision_line_list(x, y, x + test_line_x, y + test_line_y, obj_target, false, true, hit, true);

if (ds_list_size(hit) > 0) hit[| 0].image_blend = c_red;
var snd = audio_play_sound(snd_shoot, 0, false);
audio_sound_pitch(snd, random_range(0.5, 2));

ds_list_destroy(hit);