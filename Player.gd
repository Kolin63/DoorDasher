extends Area2D
var velocity
var speed = 400
var subwaySurfers = true
var lane = 0
var laneOffset = 0
signal playerDied


func _ready():
	$AnimatedSprite2D.animation = "straight"
	$AnimatedSprite2D.play()
	


func _process(delta):
	if subwaySurfers:
		subwayMove()
	
	if $AnimatedSprite2D.frame == 7 && $AnimatedSprite2D.animation != "death":
		$AnimatedSprite2D.animation = "straight"
	
	
func subwayMove():
	velocity = Vector2.ZERO
	position.x = 960
	
	if Input.is_action_just_pressed("move_up"):
		$AnimatedSprite2D.animation = "right"
		if lane != 1:
			laneOffset = 216
		lane += 1
	if Input.is_action_just_pressed("move_down"):
		$AnimatedSprite2D.animation = "left"
		if lane != -1:
			laneOffset = -216
		lane -= 1
	
	if lane < 0:
		lane = -1
		position.y = 540
	if lane == 0:
		position.y = 324
	if lane > 0:
		lane = 1
		position.y = 108
	position.y += laneOffset
	
	if laneOffset > 0:
		laneOffset -= 50
		if laneOffset < 0:
			laneOffset = 0
	if laneOffset < 0:
		laneOffset += 50
		if laneOffset > 0:
			laneOffset = 0
