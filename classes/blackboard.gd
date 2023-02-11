extends Resource
class_name Blackboard, "res://addons/yagbta/icons/Blackboard.svg"

export var id : String
export var data = {}

func set_data(key, value):
	data[key] = value

func get_data(key):
	if not data.has(key):
		return null
	return data[key]
