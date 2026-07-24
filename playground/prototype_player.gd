extends CharacterBody3D

const SPEED = 5.0

@onready var player_view: PrototypePlayerView = $PrototypePlayerView
@onready var input_controller: PlayerInputController = $PlayerInputController
@export var camera: Camera3D


func _ready() -> void:
	assert(camera)
	player_view.play_idle_animation()


func _process(_delta: float) -> void:
	input_controller.process_input()


func _physics_process(delta: float) -> void:
	_handle_player_actions()

	_rotate_player_with_mouse()

	_apply_inputs_to_velocity(delta)

	if velocity.length() < 0.01:
		player_view.play_idle_animation()
	else:
		player_view.play_running_animation()


func _rotate_player_with_mouse() -> void:
	# Get mouse global position on the screen
	var mouse_position := input_controller.get_mouse_position()
	# Ray from camera to the mouse position
	var ray_origin := camera.project_ray_origin(mouse_position)
	var ray_direction := camera.project_ray_normal(mouse_position)

	# Create a plane at the player level to intersect the ray
	var player_plane := Plane(Vector3.UP, global_position.y)
	var hit = player_plane.intersects_ray(ray_origin, ray_direction)

	# Check that the character doesn't glitch if the mouse is placed over it
	if hit and hit.distance_to(global_position) > 0.01:
		look_at(hit, Vector3.UP, true)


func _apply_inputs_to_velocity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := input_controller.get_input()
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _handle_player_actions() -> void:
	# Use match for several actions
	if input_controller.get_last_queued_action() == "shoot":
		player_view.play_shoot_animation()
