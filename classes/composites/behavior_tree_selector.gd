@icon("res://addons/yagbta/icons/BehaviorTreeSelector.svg")
extends BehaviorTreeComposite
class_name BehaviorTreeSelector


func tick(delta):
	stop_condition = SUCCESS
	continue_condition = FAILURE
	return super.tick(delta)
