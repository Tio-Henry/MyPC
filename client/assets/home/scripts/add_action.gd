extends Button

func _on_pressed() -> void:
	var ActionScene = preload("res://assets/home/interface/action_edit.tscn")
	get_tree().change_scene_to_packed(ActionScene)
