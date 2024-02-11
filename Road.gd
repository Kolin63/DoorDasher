extends Sprite2D
@export var speed = 400

func _ready():
	position = Vector2(576, 324)

func _process(delta):
	position.y += speed * delta
	
	if position.y >= 524:
		position.y = 324
