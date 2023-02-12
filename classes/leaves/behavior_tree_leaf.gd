extends BehaviorTreeNode
class_name BehaviorTreeLeaf, "res://addons/yagbta/icons/BehaviorTreeLeaf.svg"

func get_root() -> BehaviorTreeRoot:
	return tree_root

func get_actor() -> Node:
	return actor

func get_blackboard(id = "default") -> Blackboard:
	return get_root().get_blackboard(id)
