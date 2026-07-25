class_name SpendEnergyAction
extends InteractAction

@export var energy_cost = 10

func call_action(interactor: Node) -> void:
	var player := interactor as Player
	if player == null:
		return
		
	if player.energy > energy_cost:
		player.spend_energy(energy_cost)
		
		
#		Then do something else/send a signal??
