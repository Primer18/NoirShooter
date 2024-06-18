extends Node3D

@export var TurnSpeed : float = 0.5
@export var MinHeadAngle : float = -.1
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector3(1,0,1)
	pass # Replace with function body.



var _player_position : Vector3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Update Player position
	_player_position = get_node("/root/WorldEnvironment/PlayerBody").get_global_position()
	global_position = _player_position + Vector3(3, _player_position.y + .5, 0)
	print(global_position)

		
	var target_vector = global_position.direction_to(_player_position)
	
	#Did some attempts to have enemy tilt towards player, up until a certain angle.
	#will need to revisit later

	#get relative distance to player
	#var player_distance : Vector3 = abs(global_position - _player_position)
	#var distance_factor : float = sqrt(player_distance.x*player_distance.x + player_distance.z*player_distance.z)

	##_player_position.y = position.y
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
		#target_vector.y = clamp(target_vector.y, MinHeadAngle, 0)
		#
	#else:
		#pass
	#print(target_vector)
	target_vector.y = 0

	
	var target_basis = Basis.looking_at(target_vector)
	basis = basis.slerp(target_basis, TurnSpeed)


