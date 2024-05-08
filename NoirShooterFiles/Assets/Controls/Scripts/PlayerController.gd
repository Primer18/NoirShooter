extends CharacterBody3D

@export var WalkSpeed = 1.5
@export var RunSpeed = 2
@export var JumpSpeed = 2
@export var Gravity = 9.8

@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var _player_rotation : Vector3
var _camera_rotation : Vector3

var target_velocity = Vector3.ZERO


func _update_camera(delta):
	
	
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0, _mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0,0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_rotation_input = 0.0
	_tilt_input = 0.0
	
	
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y
		#print(Vector2(_rotation_input, _tilt_input))
		
func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
		
func _physics_process(delta):
	var direction = Vector3.ZERO
	

	_update_camera(delta)
	
	if Input.is_action_pressed("move_forward"):
		direction.z += 1#WalkSpeed * delta
	if Input.is_action_pressed("move_back"):
		direction.z -= 1#WalkSpeed * delta
	if Input.is_action_pressed("move_left"):
		direction.x += 1#WalkSpeed * delta
	if Input.is_action_pressed("move_right"):
		direction.x -= 1#WalkSpeed * delta
	if Input.is_action_pressed("jump"):
		direction.y += 1#JumpSpeed * delta
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$Pivot.Basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * WalkSpeed
	target_velocity.z = direction.z * WalkSpeed
	target_velocity.y = direction.y * JumpSpeed
	
	if not is_on_floor():
		target_velocity.y -= (gravity * delta)
		

	velocity = target_velocity
	print(gravity*delta)
	
	move_and_slide()

