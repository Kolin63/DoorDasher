extends Sprite2D
signal load_road

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		load_road.emit()
