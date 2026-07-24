extends Node

class_name PlayerInputController

var _input_vector: Vector2 = Vector2.ZERO
var _mouse_input_position_vector: Vector2 = Vector2.ZERO
var _action_queue: Array[String] = []


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_input_position_vector = event.global_position


func process_input() -> void:
	_input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# TODO: For each action, check if just pressed, then push to the queue
	if Input.is_action_just_pressed("shoot"):
		_action_queue.push_front("shoot")


func get_input() -> Vector2:
	return _input_vector


func get_mouse_position() -> Vector2:
	return get_viewport().get_mouse_position()


func get_last_queued_action() -> Variant:
	var last_action = _action_queue.pop_back()
	return last_action
