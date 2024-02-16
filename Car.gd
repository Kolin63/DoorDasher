extends Area2D
var speed = 500
var _lane
signal death(carLane)


func set_lane(value):
	_lane = value


func _process(delta):
	
	position.x += speed * delta
	
	if position.x >= 900 && position.x < 910:
		death.emit(_lane)
	elif position.x > 1300:
		queue_free()
