extends Node


@export var action: InteractAction # The action to trigger. Should pass in a ref
@onready var MeshInstance: Area3D = $Area3D
@onready var InteractLabel: Label3D = $InteractFlag

var player_in_area = false
var player: CharacterBody3D = null


func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("interact"):
#		Call the implemented method
		action.call_action(player)


func _ready() -> void:
	if InteractLabel:
		InteractLabel.visible = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = body
		player_in_area = true
		InteractLabel.visible = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = null
		player_in_area = false
		InteractLabel.visible = false
