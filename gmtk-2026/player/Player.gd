extends CharacterBody3D

@export var speed = 4
@export var gravity = 2


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
	
