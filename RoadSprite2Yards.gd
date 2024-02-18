extends Sprite2D
var speed = 500

func _ready():
	position = Vector2(800, 324)

func _process(delta):
	position.x += speed * delta
	
	if speed > 0:
		if position.x >= 1856:
			position.x = 800
	elif speed < 0:
		if position.x <= 800:
			position.x = 1856
