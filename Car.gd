extends Area2D
var speed = 500
var _lane
signal death(carLane)
signal police_death(carLane)
var type
var poopTex = preload("res://art/poop.png")
var carTex = preload("res://art/redcar.png")
var pizzaTex = preload("res://art/pizzapie.png")
var pineappleTex = preload("res://art/Pinnaple.png")
var attacked_police


func set_texture(texture):
	type = texture
	if texture == "car":
		scale = Vector2(1, 1)
		speed = 500
		rotation_degrees = -90
		$Sprite2D.texture = carTex
	elif texture == "poop":
		scale = Vector2(1, 1)
		speed = 1500
		rotation_degrees = 0
		$Sprite2D.texture = poopTex
	elif texture == "pizza":
		scale = Vector2(1, 1)
		speed = 1500
		rotation_degrees = 0
		$Sprite2D.texture = pizzaTex
	elif texture == "pineapple":
		scale = Vector2(0.5, 0.5)
		speed = -1500
		rotation_degrees = 0
		$Sprite2D.texture = pineappleTex
		attacked_police = false


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
		if position.x >= 900 && position.x < 930:
			death.emit(_lane)
	elif type == "pineapple":
		if position.x <= 500 && !attacked_police:
			police_death.emit(_lane)
			attacked_police = true
	
	if position.x > 1300 && type != "pineapple":
		queue_free()
	elif type == "pineappple" && position.x < 0:
		queue_free()


func _on_area_entered(area):
	queue_free() 
