extends BehaviorTreeDecorator
class_name BehaviorTreeInverter, "res://addons/yagbta/icons/BehaviorTreeInverter.svg"

func tick():
	var response = child_node.tick()
	if response == SUCCESS:
		return FAILURE
	elif response == FAILURE:
		return SUCCESS
	else:
		return RUNNING
