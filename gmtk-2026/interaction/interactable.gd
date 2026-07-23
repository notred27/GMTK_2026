extends Node

@export var action: InteractAction # The action to trigger. Should pass in a ref
@onready var MeshInstance: Area3D = $Area3D
@onready var InteractLabel: Node3D = $InteractionUI

var player_in_area = false
var player: CharacterBody3D = null

@export var min_frames_held: int = 50
var cur_frames_held = 0
var is_activated = false

@onready var ring_material: ShaderMaterial = $InteractionUI/InteractShader.material_override

func _process(delta: float) -> void:
	if player_in_area and (Input.is_action_just_pressed("interact") or Input.is_action_just_released("interact")):
		is_activated = false
		cur_frames_held = 0
		ring_material.set_shader_parameter("fill_amount", 0)
		

	if player_in_area and Input.is_action_pressed("interact"):
		cur_frames_held += 1
		var fill_amount = clamp(float(cur_frames_held) / float(min_frames_held), 0.0, 1.0)
		ring_material.set_shader_parameter("fill_amount", fill_amount)

	if cur_frames_held >= min_frames_held and not is_activated:
		is_activated = true
		action.call_action(player)
		
		


func _ready() -> void:
	if InteractLabel:
		InteractLabel.visible = false
	if ring_material == null:
		push_error("InteractShader has no material_override assigned in the Inspector")



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
