# YAGBTA

Yet Another Godot Behavior Tree Addon. Yes, *another* behavior tree addon. In my defense I'll say that when I started making this thing there weren't as many as now. I wanted a simple, mostly agnostic plugin so it can be easily ported without breaking compatibility to newer/older versions of the engine (in fact, porting it to 4.x was just changing the icon paths and the export hints) but without losing any functionality that make a behavior tree, well, a behavior tree. At the time, most plugins out there lacked one or another of those functionalities and/or had a different approach to what I was looking for, and I needed behavior trees for my projects so meh, why not. So, anyway, in case anyone is interested, this plugin has:

- Reactive and non-reactive sequences and selectors
- Random sequences and selectors
- Multiple blackboard support and shared blackboards
- Blackboards as Godot resources
- Configurable tick time (it can be used with physics process or with an internal timer)
- Standard set of decorators (Failer, Inverter, Succeeder, Repeater, UntilFails)
- Parallel composite
- Easily extended actions and conditions

Also, as said, the plugin is mostly agnostic, so main (3.x) branch should work with any Godot 3.x version, and same for 4.x brach.

To make a new action/condition, just create a new scene with a base Node as a root and add it a script that inherits from BehaviorTreeAction/BehaviorTreeCondition. Ovewrite `tick(delta)` function with your action/condition logic, call `get_actor()`  to access the tree actor or `get_root()` for the tree root in case you need it, return `SUCCESS`, `FAILURE` or 	`RUNNING` and you are done. 

To get a blackboard from the tree root, call `get_blackboard(blackboard_id)` from anywhere in the action/condition script, and use `set_data(key, value)` and `get_data(key)` to modify it. 

Everything else is standard behavior tree logic.