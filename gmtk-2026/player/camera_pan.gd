extends Camera3D

@export var pan_speed = 0.05
@export var max_cam_dist = 4

func _physics_process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()

	if mouse_pos.x >= get_viewport().size.x * 0.8:
		# Mouse is on right, pan right
		if position.length()  < max_cam_dist:
			position.x += pan_speed
			position.z += pan_speed
		else:
			position.x = max_cam_dist / sqrt(2)
			position.z = max_cam_dist / sqrt(2)
			
		
	if mouse_pos.x <= get_viewport().size.x * 0.2:
		# Mouse is on left, pan left
		if position.length() < max_cam_dist:
			position.x -= pan_speed
			position.z -= pan_speed
		else:
				position.x = -max_cam_dist / sqrt(2)
				position.z = -max_cam_dist / sqrt(2)
