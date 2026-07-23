class_name InteractAction
extends Node

@export var energy_increase_amount = 10

func call_action(interactor: Node) -> void:
	var player := interactor as Player
	if player == null:
		return
		
	player.add_energy(energy_increase_amount)
