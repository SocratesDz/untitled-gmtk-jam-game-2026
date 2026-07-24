extends Node3D
class_name PrototypePlayerView

enum MovementState { IDLE, RUNNING }

var movement_state: MovementState = MovementState.IDLE

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
	movement_state = MovementState.IDLE


func play_running_animation() -> void:
	movement_state = MovementState.RUNNING
