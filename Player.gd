extends Area2D
var velocity
var speed = 400
var subwaySurfers = true
var lane = 0


func _ready():
	$AnimatedSprite2D.play()
	


func _process(delta):
	if subwaySurfers:
		subwayMove(delta)
	else:
		normalMove(delta)


func normalMove(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
	
	position += velocity * speed * delta
	
	
func subwayMove(delta):
	velocity = Vector2.ZERO
	position.x = 530
	
	if Input.is_action_just_pressed("move_right"):
		lane += 1
	if Input.is_action_just_pressed("move_left"):
		lane -= 1
	
	if lane < 0:
		lane = -1
		position.x = 192
	if lane == 0:
		position.x = 576
	if lane > 0:
		lane = 1
		position.x = 960
	
