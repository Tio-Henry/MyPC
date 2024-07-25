extends Control

@onready var NameEdit : LineEdit = $VBoxContainer/NameEdit
@onready var CommandTypeOptions : OptionButton = $VBoxContainer/CommandTypeOptions
@onready var CommandEdit : LineEdit = $VBoxContainer/CommandEdit

@onready var HomeScene = preload("res://assets/home/home.tscn")

var incorrect_color : = Color("de1d00")
var normal_color : = Color("ffffff")

func _on_add_button_pressed() -> void:
	if NameEdit.text != "":
		if CommandTypeOptions.selected != -1:
			if CommandEdit.text != "":
				System.create_action(NameEdit.text,
				CommandTypeOptions.get_item_text(CommandTypeOptions.get_selected_id()),
				CommandEdit.text)
				System.save_user_data()
				get_tree().change_scene_to_packed(HomeScene)
			else:
				CommandEdit.modulate = incorrect_color
		else:
			CommandTypeOptions.modulate = incorrect_color
	else:
		NameEdit.modulate = incorrect_color

#region Signais Simples

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_packed(HomeScene)

func _on_name_edit_text_changed(_new_text: String) -> void:
	NameEdit.modulate = normal_color

func _on_command_type_options_item_selected(_index: int) -> void:
	CommandTypeOptions.modulate = normal_color

func _on_command_edit_text_changed(_new_text: String) -> void:
	CommandEdit.modulate = normal_color
#endregion
