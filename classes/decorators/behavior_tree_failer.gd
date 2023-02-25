@icon("res://addons/yagbta/icons/BehaviorTreeFailer.svg")
extends BehaviorTreeDecorator
class_name BehaviorTreeFailer

func tick(delta):
	var response = child_node.tick(delta)
	if response == RUNNING:
		return RUNNING
	return FAILURE
