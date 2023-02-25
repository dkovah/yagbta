@icon("res://addons/yagbta/icons/BehaviorTreeUntilFails.svg")
extends BehaviorTreeDecorator
class_name BehaviorTreeUntilFails
	
	
func tick(delta):
	var current_status = child_node.tick(delta)
	if current_status == RUNNING or current_status == SUCCESS:
		return RUNNING
	return FAILURE
