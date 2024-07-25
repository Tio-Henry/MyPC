extends Control

var actions_data : Array
func _ready() -> void:
	await System.get_user_data()
	actions_data = System.actions
	if actions_data.size() > 0:
		for i in range(actions_data.size()):
			var ActionBtn = preload("res://assets/home/nodes/action_button.tscn").instantiate()
			ActionBtn.data = actions_data[i]
			$GridContainer.add_child(ActionBtn)
