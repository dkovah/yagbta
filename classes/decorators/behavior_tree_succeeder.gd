extends BehaviorTreeDecorator
class_name BehaviorTreeSucceeder, "res://addons/yagbta/icons/BehaviorTreeSucceeder.svg"

func tick():
	var response = child_node.tick()
	if response == RUNNING:
		return RUNNING
	return SUCCESS
