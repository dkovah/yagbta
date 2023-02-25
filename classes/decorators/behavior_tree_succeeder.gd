@icon("res://addons/yagbta/icons/BehaviorTreeSucceeder.svg")
extends BehaviorTreeDecorator
class_name BehaviorTreeSucceeder

func tick(delta):
	var response = child_node.tick(delta)
	if response == RUNNING:
		return RUNNING
	return SUCCESS
