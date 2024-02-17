extends Area2D
var speed = 500
var _lane
signal death(carLane)
var type
var poopTex = preload("res://art/poop.png")
var carTex = preload("res://art/redcar.png")


func set_texture(texture):
	type = texture
	if texture == "car":
		rotation = -90
		$Sprite2D.texture = carTex
	elif texture == "poop":
		rotation = 0
		$Sprite2D.texture = poopTex


func set_lane(value):
	_lane = value


func _process(delta):
	if type == "poop" && position.x < 270:
		visible = false
	else:
		visible = true
	
	position.x += speed * delta
	
	if position.x >= 900 && position.x < 910:
		death.emit(_lane)
	elif position.x > 1300:
		queue_free()
