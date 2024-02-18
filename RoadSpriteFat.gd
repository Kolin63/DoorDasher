extends Sprite2D
var speed = 500

func _ready():
	position = Vector2(802, 324)

func _process(delta):
	position.x += speed * delta
	
	if speed > 0:
		if position.x >= 1762:
			position.x = 802
	elif speed < 0:
		if position.x <= 802:
			position.x = 1762
