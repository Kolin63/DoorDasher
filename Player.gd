extends Area2D
var velocity
var speed = 400
var subwaySurfers = true
var lane = 0
var laneOffset = 0


func _ready():
	$AnimatedSprite2D.animation = "straight"
	$AnimatedSprite2D.play()
	


func _process(delta):
	if subwaySurfers:
		subwayMove(delta)
	
	if $AnimatedSprite2D.frame == 7 && $AnimatedSprite2D.animation != "death":
		$AnimatedSprite2D.animation = "straight"
	
	
func subwayMove(delta):
	velocity = Vector2.ZERO
	position.x = 530
	
	if Input.is_action_just_pressed("move_right"):
		$AnimatedSprite2D.animation = "right"
		lane += 1
		laneOffset = -384
	if Input.is_action_just_pressed("move_left"):
		$AnimatedSprite2D.animation = "left"
		lane -= 1
		laneOffset = 384
	
	if lane < 0:
		lane = -1
		position.x = 192
	if lane == 0:
		position.x = 576
	if lane > 0:
		lane = 1    
		position.x = 960
	position.x += laneOffset
	
	if laneOffset > 0:
		laneOffset -= 50
		if laneOffset < 0:
			laneOffset = 0
	if laneOffset < 0:
		laneOffset += 50
		if laneOffset > 0:
			laneOffset = 0





