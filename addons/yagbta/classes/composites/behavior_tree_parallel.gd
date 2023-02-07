extends BehaviorTreeComposite
class_name BehaviorTreeParallel, "res://addons/yagbta/icons/BehaviorTreeParallel.svg"

func tick():
	for node in stack:
		node.tick()
	
	if random:
		stack.shuffle()
	return SUCCESS
