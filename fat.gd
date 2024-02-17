extends AnimatedSprite2D
var laneOffset = 0
var lane = 0
var playerLocked


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !playerLocked:
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
