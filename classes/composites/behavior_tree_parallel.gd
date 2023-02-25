@icon("res://addons/yagbta/icons/BehaviorTreeParallel.svg")
extends BehaviorTreeComposite
class_name BehaviorTreeParallel

func tick(delta):
	for node in stack:
		node.tick(delta)
	
	if random:
		stack.shuffle()
	return SUCCESS
