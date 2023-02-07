extends BehaviorTreeBranchedNode
class_name BehaviorTreeRoot, "res://addons/yagbta/icons/BehaviorTreeRoot.svg"

export(NodePath) var actor_path
export(bool) var active = true
export(float, 0.01, 5, 0.01) var tick_time = 0.5

export(Resource) var blackboard
var child_node

func _ready():
	
	if blackboard == null:
		blackboard = Blackboard.new()
	
	child_node = get_children()[0]
	
	var timer = Timer.new()
	timer.name = "tick_timer"
	timer.wait_time = tick_time
	add_child(timer)
	timer.connect("timeout", self, "_on_tick_timer_timeout")
	timer.start()
	
	if actor_path == "":
		actor = get_parent()
	else:
		actor = get_node(actor_path)
		
	tree_root = self
	
	setup_children(self, actor)
	if active:
		tick()

func activate():
	active = true
	tick()


func _on_tick_timer_timeout():
	tick()


func tick():
	child_node.tick()


func get_blackboard():
	return blackboard

