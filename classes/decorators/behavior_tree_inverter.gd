@icon("res://addons/yagbta/icons/BehaviorTreeInverter.svg")
extends BehaviorTreeDecorator
class_name BehaviorTreeInverter

func tick(delta):
	var response = child_node.tick(delta)
	if response == SUCCESS:
		return FAILURE
	elif response == FAILURE:
		return SUCCESS
	else:
		return RUNNING
