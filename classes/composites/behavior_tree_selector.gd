extends BehaviorTreeComposite
class_name BehaviorTreeSelector, "res://addons/yagbta/icons/BehaviorTreeSelector.svg"


func tick():
	stop_condition = SUCCESS
	continue_condition = FAILURE
	return .tick()
