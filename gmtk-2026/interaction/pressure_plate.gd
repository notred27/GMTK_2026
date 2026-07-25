extends Node

@export var action: InteractAction
@onready var area: Area3D = $Area3D

var bodies_on_plate: Array[Node3D] = []
var is_activated := false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not _is_valid_body(body):
		return
	if not bodies_on_plate.has(body):
		bodies_on_plate.append(body)
	_update_activation()

func _on_area_3d_body_exited(body: Node3D) -> void:
	bodies_on_plate.erase(body)
	_update_activation()

func _is_valid_body(body: Node3D) -> bool:
	return body.is_in_group("Player") or body.is_in_group("Moveable")



func _update_activation() -> void:
	var should_be_active = bodies_on_plate.size() > 0
	if should_be_active and not is_activated:
		is_activated = true
		action.call_action(bodies_on_plate[0])
	elif not should_be_active and is_activated:
		is_activated = false
		action.deactivate_action(null)
