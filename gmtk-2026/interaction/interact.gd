extends Node


@onready var MeshInstance: Area3D = $Area3D
@export var action: PackedScene

var player_in_area = false


func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("interact"):
		print("ACTIVATED")
#
#func _ready() -> void:
	#MeshInstance.connect("_on_area_3d_body_entered", _on_area_3d_body_entered)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true
	
	


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
