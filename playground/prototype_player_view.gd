extends Node3D
class_name PrototypePlayerView

var is_running: bool = false
var is_idle: bool = false

@onready var animation_tree = $AnimationTree
var motion_state_machine: AnimationNodeStateMachine
var action_state_machine: AnimationNodeStateMachine
var state_machine_blend: AnimationNodeBlend2


func _ready() -> void:
	var blend_tree := animation_tree.tree_root as AnimationNodeBlendTree
	if blend_tree.has_node("MotionStateMachine"):
		motion_state_machine = blend_tree.get_node("MotionStateMachine")
	if blend_tree.has_node("ActionStateMachine"):
		action_state_machine = blend_tree.get_node("ActionStateMachine")
	if blend_tree.has_node("StateMachineBlend"):
		state_machine_blend = blend_tree.get_node("StateMachineBlend")
	assert(motion_state_machine)
	assert(action_state_machine)
	assert(state_machine_blend)


func play_idle_animation() -> void:
	is_running = false
	is_idle = true
	motion_state_machine.set("parameters/conditions/is_idle", is_idle)
	motion_state_machine.set("parameters/conditions/is_running", is_running)


func play_running_animation() -> void:
	is_running = true
	is_idle = false
	motion_state_machine.set("parameters/conditions/is_idle", is_idle)
	motion_state_machine.set("parameters/conditions/is_running", is_running)
