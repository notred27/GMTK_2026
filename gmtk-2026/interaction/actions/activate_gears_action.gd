class_name ActivateGearsAction
extends InteractAction

@export var gear_puzzle: GearPuzzle

func call_action(interactor: Node) -> void:
	gear_puzzle.set_powered(true)

func deactivate_action(interactor: Node) -> void:
	gear_puzzle.set_powered(false)
