class_name Player
extends CharacterBody3D

@export var speed = 4
@export var gravity = 2
@export var energy = 100.0
@export var max_energy = 120.0
@export var energy_drain_rate = 1.0

@export var spotlight: SpotLight3D
@export var fill_light: DirectionalLight3D
@export var min_ground_radius := 2.0
@export var max_ground_radius := 10.0
@export var min_light_energy := 2.0
@export var max_light_energy := 10.0
@export var min_fill_light_energy := 0.2
@export var max_fill_light_energy := 1.0

@export var push_speed: float = 2.0


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
	push_rigid_bodies()
	drain_energy(delta)


func push_rigid_bodies() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal()
			push_dir.y = 0
			var target_velocity = push_dir * push_speed
			collider.linear_velocity.x = target_velocity.x
			collider.linear_velocity.z = target_velocity.z
			
			
func drain_energy(delta: float) -> void:
	energy = max(energy - energy_drain_rate * delta, 0.0)
	$PlayerUI/CurrentEnergy.text = "Current Energy: %s" % [int(energy)]
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


func spend_energy(val: float):
	energy = min(energy - val, max_energy)
