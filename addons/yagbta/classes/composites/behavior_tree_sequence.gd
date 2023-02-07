extends BehaviorTreeComposite
class_name BehaviorTreeSequence, "res://addons/yagbta/icons/BehaviorTreeSequence.svg"


func tick():
	stop_condition = FAILURE
	continue_condition = SUCCESS
	return .tick()
