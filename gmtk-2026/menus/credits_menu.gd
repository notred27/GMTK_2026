extends Control


func _on_back_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
