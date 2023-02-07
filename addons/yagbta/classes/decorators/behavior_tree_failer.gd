extends BehaviorTreeDecorator
class_name BehaviorTreeFailer, "res://addons/yagbta/icons/BehaviorTreeFailer.svg"

func tick():
	var response = child_node.tick()
	if response == RUNNING:
		return RUNNING
	return FAILURE
