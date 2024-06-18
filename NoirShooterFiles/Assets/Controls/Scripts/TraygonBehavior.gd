extends CharacterBody3D


@onready var _nav_agent = $NavigationAgent3D
@export var TURN_SPEED : float = 0.5
@export var MIN_HEAD_ANGLE : float = -.1
@export var MOVE_SPEED : float = 1


var Player_Position : Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector3(4,0,1)
	pass # Replace with function body.


func update_turn_basis():
	var target_vector : Vector3

	
	target_vector = global_position.direction_to(Player_Position)
	target_vector.y = 0 #Set the 'seen' y value of the player to 0, so it cannot look up or down 
	target_vector = target_vector.normalized()
	if target_vector != Vector3.ZERO:
		var target_basis = Basis.looking_at(target_vector)
		basis = basis.slerp(target_basis, TURN_SPEED)
		#print(basis)
	#Did some attempts to have enemy tilt towards player, up until a certain angle.
	#will need to revisit later

	#get relative distance to player
	#var player_distance : Vector3 = abs(global_position - Player_Position)
	#var distance_factor : float = sqrt(player_distance.x*player_distance.x + player_distance.z*player_distance.z)

	##Player_Position.y = position.y
	##print("y:", player_distance.y)
		#
	#if distance_factor < 1:
		##print("<1")
		##player_y = position.y
		#pass
	#if distance_factor < 2.5:
		##print("<2.5")
		#pass
	#
	#if clamp_vector_component < 0:
		#target_vector.y = clamp(target_vector.y, MIN_HEAD_ANGLE, 0)
		#
	#else:
		#pass
		


func update_velocity_vector():
	var _current_location : Vector3 = position
	var _next_location : Vector3 = _nav_agent.target_position
	var _new_velocity : Vector3 = (_next_location - _current_location).normalized() * MOVE_SPEED
 	
	velocity = velocity.move_toward(_new_velocity, .25)
	move_and_slide()
	
func _physics_process(delta):
	
	
	update_velocity_vector()
	update_turn_basis()


func update_next_location(target_location):
	_nav_agent.target_position = target_location
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#var _player_node : NodePath
	#if(get_tree().get_nodes_in_group("Player").size() == 1):
		#_player_node = get_tree().get_first_node_in_group("Player").get_path()
	##Update Player position
	#Player_Position = get_node(_player_node).get_global_position()
	Player_Position = Global.get_player_location()
	#print(global_position)
	update_next_location(Player_Position)
		
	#var target_vector = global_position.direction_to(_player_position)

	#update_turn_location(_player_position)

