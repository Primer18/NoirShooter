extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var window : Rect2
	window = get_viewport_rect()
	var x_pos : float = (window.size.x / 2.0) - 20
	var y_pos : float = (window.size.y / 2.0) - 20
	position.x = x_pos 
	position.y = y_pos
	##position = Vector2(940, 464)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
