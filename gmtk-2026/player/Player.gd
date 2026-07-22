extends CharacterBody3D

@export var speed = 4
@export var gravity = 2


@export var energy = 100.0
@export var energy_drain_rate = 5.0


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
	#print(energy)
