class_name Player
extends CharacterBody3D

@export var speed = 4
@export var gravity = 2
@export var energy = 100.0
@export var max_energy = 100.0
@export var energy_drain_rate = 5.0

@export var spotlight: SpotLight3D
@export var fill_light: DirectionalLight3D
@export var min_ground_radius := 2.0
@export var max_ground_radius := 10.0
@export var min_light_energy := 2.0
@export var max_light_energy := 10.0
@export var min_fill_light_energy := 0.2
@export var max_fill_light_energy := 1.0


func move_player():
	var dir = Vector3.ZERO
	var move_dir = Input.get_vector("backward","forward","left", "right")
	dir.x = move_dir.x
	dir.z = move_dir.y
	dir.y -= gravity
	velocity = dir * speed

func _physics_process(delta: float) -> void:
	move_player()
	move_and_slide()
	drain_energy(delta)

func drain_energy(delta: float) -> void:
	energy = max(energy - energy_drain_rate * delta, 0.0)
	$PlayerUI/CurrentEnergy.text = "Current Energy: %s" % [energy]
	update_spotlight()

func update_spotlight() -> void:
	if spotlight == null:
			return
	var t = energy / max_energy
	var ground_radius = remap(energy, 0.0, max_energy, min_ground_radius, max_ground_radius)
	spotlight.spot_angle = rad_to_deg(atan(ground_radius / spotlight.spot_range))
	spotlight.light_energy = lerp(min_light_energy, max_light_energy, t)
	
	if fill_light:
		fill_light.light_energy = lerp(min_fill_light_energy, max_fill_light_energy, t)
	
func add_energy(val: float):
	energy = min(energy + val, max_energy)
