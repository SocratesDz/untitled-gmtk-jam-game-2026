extends Node3D
class_name PrototypePlayerView

enum MovementState { IDLE, RUNNING }
enum ActionState { NONE, THROW }

var movement_state: MovementState = MovementState.IDLE
var action_state: ActionState = ActionState.NONE

@onready var animation_tree = $AnimationTree

func _ready() -> void:
	var blend_tree := animation_tree.tree_root as AnimationNodeBlendTree
	assert(blend_tree.has_node("MotionStateMachine"))
	assert(blend_tree.has_node("ActionStateMachine"))
	assert(blend_tree.has_node("StateMachineBlend"))


func play_idle_animation() -> void:
	movement_state = MovementState.IDLE


func play_running_animation() -> void:
	movement_state = MovementState.RUNNING


func play_shoot_animation() -> void:
	var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/ActionStateMachine/playback")
	playback.travel("OverhandThrow")
