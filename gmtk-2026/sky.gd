extends Node3D

@export var day_length_seconds: float = 30.0
@export var sun: DirectionalLight3D
@export var world_environment: WorldEnvironment

var start_time: float = 0.48
var end_time: float = 0.75
var elapsed: float = 0.0
var time_of_day: float = start_time
var day_ended: bool = false

func _process(delta):
	if day_ended:
		return

	elapsed += delta
	var progress = clamp(elapsed / day_length_seconds, 0.0, 1.0)

	time_of_day = lerp(start_time, end_time, progress)

	if progress >= 1.0:
		day_ended = true

	update_sun()

func update_sun():
	var sun_angle_deg = (time_of_day * 360.0) - 90.0
	sun.rotation_degrees.x = sun_angle_deg

	var sun_height = sin(deg_to_rad(sun_angle_deg))
	sun.light_energy = clamp(sun_height, 0.05, 1.0)

	var sky_material = world_environment.environment.sky.sky_material
	if sky_material is ProceduralSkyMaterial:
		var night_amount = clamp(1.0 - sun_height, 0.0, 1.0)
		sky_material.sky_top_color = Color.WHITE.lerp(Color.BLACK, night_amount)
		
	if day_ended:
		print("Game Over")
#		Game over trigger logic here
