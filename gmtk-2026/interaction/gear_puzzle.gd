class_name GearPuzzle
extends Node

@export var gears: Array[Gear] = []
@export var driver_gear: Gear
@export var output_gear: Gear
@export var driver_rpm: float = 60.0
@export var target_output_rpm: float = 30.0
@export var rpm_tolerance: float = 2.0

var is_powered := false

func set_powered(value: bool) -> void:
	is_powered = value

func _physics_process(delta: float) -> void:
	if driver_gear:
		_update_driven_gears()

func _build_mesh_graph() -> Dictionary:
	var graph := {}
	for gear in gears:
		graph[gear] = gear.get_meshing_gears(gears)
	return graph

func _update_driven_gears() -> void:
	if not is_powered:
		for gear in gears:
			gear.set_driven_speed(0.0, 1)
		return

	var graph = _build_mesh_graph()
	var rpm_map := {driver_gear: driver_rpm}
	var direction_map := {driver_gear: 1}
	var visited := {driver_gear: true}
	var queue: Array = [driver_gear]

	while queue.size() > 0:
		var current: Gear = queue.pop_front()
		for neighbor in graph.get(current, []):
			if not visited.has(neighbor):
				visited[neighbor] = true
				var ratio = float(current.teeth_count) / float(neighbor.teeth_count)
				rpm_map[neighbor] = rpm_map[current] * ratio
				direction_map[neighbor] = -direction_map[current]
				queue.append(neighbor)

	for gear in gears:
		if visited.has(gear):
			gear.set_driven_speed(rpm_map[gear], direction_map[gear])
		else:
			gear.set_driven_speed(0.0, 1)

func are_all_aligned() -> bool:
	var graph = _build_mesh_graph()
	var path = _find_path(graph, driver_gear, output_gear)
	if path.is_empty():
		return false

	var rpm = driver_rpm
	for i in range(path.size() - 1):
		rpm *= float(path[i].teeth_count) / float(path[i + 1].teeth_count)

	return abs(rpm - target_output_rpm) <= rpm_tolerance

func _find_path(graph: Dictionary, start: Gear, target: Gear) -> Array:
	var visited := {start: true}
	var queue: Array = [[start]]
	while queue.size() > 0:
		var path: Array = queue.pop_front()
		var node = path[-1]
		if node == target:
			return path
		for neighbor in graph.get(node, []):
			if not visited.has(neighbor):
				visited[neighbor] = true
				var new_path = path.duplicate()
				new_path.append(neighbor)
				queue.append(new_path)
	return []
