extends Sprite2D
var speed = 500

func _ready():
	position = Vector2(483, 324)

func _process(delta):
	position.x += speed * delta
	
	if speed > 0:
		if position.x >= 643:
			position.x = 483
	elif speed < 0:
		if position.x <= 483:
			position.x = 643
