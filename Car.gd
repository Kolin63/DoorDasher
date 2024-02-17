extends Area2D
var speed = 500
var _lane
signal death(carLane)
var type
var poopTex = preload("res://art/poop.png")
var carTex = preload("res://art/redcar.png")
var pizzaTex = preload("res://art/pizzapie.png")


func set_texture(texture):
	type = texture
	if texture == "car":
		speed = 500
		rotation_degrees = -90
		$Sprite2D.texture = carTex
	elif texture == "poop":
		speed = 1500
		rotation_degrees = 0
		$Sprite2D.texture = poopTex
	elif texture == "pizza":
		speed = 1500
		rotation_degrees = 0
		$Sprite2D.texture = pizzaTex


func set_lane(value):
	_lane = value


func _process(delta):
	if type == "poop" && position.x < 270 || type == "pizza" && position.x < 290:
		visible = false
	else:
		visible = true
	
	position.x += speed * delta
	
	if type == "car":
		if position.x >= 900 && position.x < 910:
			death.emit(_lane)
		
	elif type == "poop" || type == "pizza":
		if position.x >= 900 && position.x < 980:
			death.emit(_lane)
	if position.x > 1300:
			queue_free()
