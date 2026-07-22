extends CharacterBody3D

var speed = 10

func move_player():
	var dir = Vector3.ZERO
	var move_dir = Input.get_vector("backward","forward","left", "right")

	dir.x = move_dir.x
	dir.z = move_dir.y
	velocity = dir * speed

func _physics_process(delta: float) -> void:
	move_player()
	move_and_slide()
	
