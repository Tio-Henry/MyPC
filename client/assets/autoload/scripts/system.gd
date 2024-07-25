extends HTTPRequest

var data_path : String = "user://data.dat"
var data : Dictionary = {"ip": "localhost", "port": "5000", "key" : 000000}
var link : String 
var actions : Array = []

func validate_connection(ip_address: String, port: String, key: String) -> Array:
	var error = request("http://" + ip_address + ":" + port + "/" + key)
	if error == OK:
		var validator = await request_completed
		if await validator[3].get_string_from_utf8() == "True":
			data["ip"] = ip_address
			data["port"] = port
			data["key"] = key
			link = "http://" + data["ip"] + ":" + data["port"] + "/"
			return [true, 0]
		else:
			return [false, 1]
	else:
		return [false, 2]

func save_connection():
	FileAccess.open(data_path,FileAccess.WRITE).store_var(data)

func load_connection() -> bool:
	var data_file = FileAccess.open(data_path,FileAccess.READ).get_var()
	if Array(await validate_connection(data_file["ip"],data_file["port"],
	data_file["key"]))[0]:
		data.merge(data_file, true)
		return true
	else:
		return false

func create_action(action_name: String, command_type: String, paraments: String):
	actions.append(
		{
			"name" : action_name,
			"command_type" : command_type,
			"paraments" : paraments
		}
	)

func save_user_data():
	var json_string = JSON.stringify(actions)
	var headers = ["Content-Type: application/json"]
	request(link + "set_user_data/" + data["key"],headers,HTTPClient.METHOD_POST,json_string)
	
func get_user_data():
	var error: = request(link + "get_user_data/" + data["key"])
	if error == OK:
		var user_data = await request_completed
		var json = JSON.new()
		var err = json.parse(await user_data[3].get_string_from_utf8())
		if err == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_ARRAY:
				actions = data_received
			else:
				print("Unexpected data")
		else:
			print("JSON Parse Error: ", json.get_error_message())
		
		
func open(application: String) -> void:
	request(link + "start/" + application + "/" + data["key"])
