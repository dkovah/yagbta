@icon( "res://addons/yagbta/icons/BehaviorTreeRoot.svg")
extends BehaviorTreeBranchedNode
class_name BehaviorTreeRoot

@export var actor_path: NodePath
@export var active: bool = true
@export var use_physics_process: bool = true
@export_range(0.01, 5, 0.01) var tick_time = 0.5 # (float, 0.01, 5, 0.01)

@export var blackboards : Array[Blackboard]
var child_node

func _ready():
	
	var no_default_blackboard = blackboards.is_empty()
	
	for blackboard in blackboards:
		if blackboard.id == "default":
			no_default_blackboard = false
	
	if no_default_blackboard:
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
		timer.connect("timeout",Callable(self,"_on_tick_timer_timeout"))
		timer.start()
	
	if actor_path.is_empty():
		actor = get_parent()
	else:
		actor = get_node(actor_path)
		
	tree_root = self
	
	setup_children(self, actor)
	if active:
		tick(1)


func _physics_process(delta):
	tick(delta)


func activate():
	active = true
	tick(1)


func _on_tick_timer_timeout():
	tick(1)


func tick(delta):
	child_node.tick(delta)


func get_blackboard(id) -> Blackboard:
	for b in blackboards:
		if b.id == id:
			return b
	return blackboards[0]

