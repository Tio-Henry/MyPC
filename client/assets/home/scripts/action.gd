extends Button

var data : Dictionary

func _ready() -> void:
	self.text = data["name"]

func _on_pressed() -> void:
	match data["command_type"]:
		"start":
			System.open(data["paraments"])
