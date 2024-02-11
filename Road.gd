extends Sprite2D
var speed = 800

func _ready():
	position = Vector2(576, 324)

func _process(delta):
	position.y += speed * delta
	
	if position.y >= 524:
		position.y = 324
