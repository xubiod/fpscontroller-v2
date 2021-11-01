function macros(){
	#macro KEY_UP (keyboard_check(vk_up) || keyboard_check(ord("W")))
	#macro KEY_DOWN (keyboard_check(vk_down) || keyboard_check(ord("S")))
	#macro KEY_LEFT (keyboard_check(vk_left) || keyboard_check(ord("A")))
	#macro KEY_RIGHT (keyboard_check(vk_right) || keyboard_check(ord("D")))
	
	#macro KEY_JUMP (keyboard_check_pressed(vk_space))
	
	#macro MOVE_HORIZONTAL sign(KEY_RIGHT - KEY_LEFT)
	#macro MOVE_VERTICAL sign(KEY_DOWN - KEY_UP)
	
	#macro SENSITIVITY 0.75
	#macro SPEED 4
	
	#macro HITSCAN_LENGTH 2048
	#macro HEIGHTMAP_MULTIPLIER 8
	#macro MAX_JUMP 24
}