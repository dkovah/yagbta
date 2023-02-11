extends BehaviorTreeBranchedNode
class_name BehaviorTreeRoot, "res://addons/yagbta/icons/BehaviorTreeRoot.svg"

export(NodePath) var actor_path
export(bool) var active = true
export(float, 0.01, 5, 0.01) var tick_time = 0.5
export(bool) var use_physics_process = false

export(Array, Resource) var blackboards
var child_node

func _ready():
	
	if blackboards.empty():
		var default_blackboard := Blackboard.new()
		default_blackboard.id = "default"
		blackboards.append(default_blackboard)
	
	child_node = get_children()[0]
	
	if not use_physics_process:
		set_physics_process(false)
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


func _physics_process(delta):
	tick()


func activate():
	active = true
	tick()


func _on_tick_timer_timeout():
	tick()


func tick():
	child_node.tick()


func get_blackboard(id):
	for b in blackboards:
		if b.id == id:
			return b

