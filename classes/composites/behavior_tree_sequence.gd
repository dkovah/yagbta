@icon("res://addons/yagbta/icons/BehaviorTreeSequence.svg")
extends BehaviorTreeComposite
class_name BehaviorTreeSequence


func tick(delta):
	stop_condition = FAILURE
	continue_condition = SUCCESS
	return super.tick(delta)
