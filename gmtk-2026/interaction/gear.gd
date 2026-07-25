class_name Gear
extends RigidBody3D

@export var teeth_count: int = 8
@export var radius: float = 1.0
@export var mesh_tolerance: float = 0.15

func get_meshing_gears(all_gears: Array[Gear]) -> Array[Gear]:
	var meshed: Array[Gear] = []
	for other in all_gears:
		if other == self:
			continue
		var dist = global_position.distance_to(other.global_position)
		var expected = radius + other.radius
		if abs(dist - expected) <= mesh_tolerance:
			meshed.append(other)
	return meshed

func set_driven_speed(rpm: float, direction: int) -> void:
	var rad_per_sec = (rpm / 60.0) * TAU
	angular_velocity = Vector3(0, rad_per_sec * direction, 0)
