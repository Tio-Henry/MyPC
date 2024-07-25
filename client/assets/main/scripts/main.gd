extends Control

@onready var IPEdit : = $Menu/VBoxContainer/Address/IPEdit
@onready var PortEdit : = $Menu/VBoxContainer/Address/PortEdit
@onready var PasswordEdit : = $Menu/VBoxContainer/PasswordEdit

var incorrect_color : = Color("de1d00")
var normal_color : = Color("ffffff")

func _ready() -> void:
	if FileAccess.file_exists(System.data_path):
		if await System.load_connection():
			var HomeScene = preload("res://assets/home/home.tscn")
			get_tree().change_scene_to_packed(HomeScene)

func _on_connect_btn_pressed() -> void:
	if IPEdit.text != "":
		if PortEdit.text != "":
			if PasswordEdit.text != "":
				var data = await System.validate_connection(IPEdit.text,PortEdit.text, PasswordEdit.text)
				if data[0] == true:
					var HomeScene : = preload("res://assets/home/home.tscn")
					if $Menu/VBoxContainer/HBoxContainer/CheckBox.pressed:
						System.save_connection()
					get_tree().change_scene_to_packed(HomeScene)
				else:
					match data[1]:
						1:
							PasswordEdit.modulate = incorrect_color
						2:
							IPEdit.modulate = incorrect_color
							PortEdit.modulate = incorrect_color
			else:
				PasswordEdit.modulate = incorrect_color
		else:
			PortEdit.modulate = incorrect_color
	else:
		IPEdit.modulate = incorrect_color

func _on_ip_edit_text_changed(_new_text: String) -> void:
	IPEdit.modulate = normal_color

func _on_port_edit_text_changed(_new_text: String) -> void:
	PortEdit.modulate = normal_color

func _on_password_edit_text_changed(_new_text: String) -> void:
	PasswordEdit.modulate = normal_color
