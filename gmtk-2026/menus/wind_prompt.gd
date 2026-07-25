class_name SkillCheckPopup
extends Control

signal success
signal failed

@export var streak_to_beat: int = 3
@export var marker_speed: float = 200.0
@export var target_width_ratio: float = 0.2   # 20% of bar width
@export var interact_action: StringName = "interact"

@onready var bar_container: Control = $Panel/MarginContainer/VBoxContainer/BarContainer
@onready var target_zone: ColorRect = $Panel/MarginContainer/VBoxContainer/BarContainer/Target
@onready var marker: ColorRect = $Panel/MarginContainer/VBoxContainer/BarContainer/Cursor
@onready var streak_label: Label = $Panel/MarginContainer/VBoxContainer/StreakLabel


var direction := 1
var bar_width := 300.0

var streak := 0


func _ready() -> void:
	streak_label.text = "%s!" % [streak_to_beat]
	bar_width = bar_container.size.x
	_randomize_target(target_width_ratio)
	marker.position.x = 0

func _randomize_target(width) -> void:
	var target_w = bar_width * width
	var max_x = bar_width - target_w
	target_zone.position.x = randf() * max_x
	target_zone.size.x = target_w

func _process(delta: float) -> void:
	marker.position.x += direction * marker_speed * delta

	if marker.position.x >= bar_width - marker.size.x:
		marker.position.x = bar_width - marker.size.x
		direction = -1
	elif marker.position.x <= 0:
		marker.position.x = 0
		direction = 1

	if Input.is_action_just_pressed(interact_action):
		_check_result()

func _check_result() -> void:
	var marker_center = marker.position.x + marker.size.x * 0.5
	var target_start = target_zone.position.x
	var target_end = target_zone.position.x + target_zone.size.x


	if marker_center >= target_start and marker_center <= target_end:
		streak += 1
		streak_label.text = "%s!" % [streak_to_beat - streak]
		_randomize_target(target_width_ratio - streak * 0.04)
		if streak_to_beat <= streak:
			success.emit()
			
	else:
		streak_label.text = "%s!" % [streak_to_beat]
		failed.emit()
		streak = 0
		_randomize_target(target_width_ratio)
		

	#queue_free()
