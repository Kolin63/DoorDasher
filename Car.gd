extends Area2D
var speed = 400

func _ready():
	position.y = -105
	
	var lane = randi_range(-1, 1)
	if lane < 0:
		lane = -1
		position.x = 192
	if lane == 0:
		position.x = 576
	if lane > 0:
		lane = 1
		position.x = 960


func _process(delta):
	position.y += 800 * delta
