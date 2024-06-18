extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_player_location():
	var _player_node : NodePath
	if(get_tree().get_nodes_in_group("Player").size() == 1):
		_player_node = get_tree().get_first_node_in_group("Player").get_path()
		
	return get_node(_player_node).get_global_position()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
