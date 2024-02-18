extends Node2D
var animationStage
signal load_police


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialouge.hide_dialouge()
	$police.position = Vector2(1234, 350)
	animationStage = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animationStage == 5:
		$Dialouge.say("Pizza Police", "PREPARE TO SUFFER!")
		if Input.is_action_just_pressed("left_click"):
			$Dialouge.hide_dialouge()
			load_police.emit()
	elif animationStage == 4:
		$Dialouge.say("Pizza Police", "I, the Pizza Police, have sworn it my duty to\nremove such foul fruits from any pizza.")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 5
	elif animationStage == 3:
		$Dialouge.say("Pizza Police", "Wait.\nWhy are there PINEAPPLES ON MY PIZZA?")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 4
	elif animationStage == 2:
		$Dialouge.say("", "The Pizza Police opens the box and examines the pizza, \nchecking for errors")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 3
	elif animationStage == 1:
		$Dialouge.show_dialouge()
		$Dialouge.say("Pizza Police", "Oh good, my pizza is here.")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 2
	elif animationStage == 0:
		$police.position.x -= 400 * delta
		if $police.position.x <= 600:
			animationStage = 1
		if Input.is_action_just_pressed("left_click"):
			$police.position.x = 600
	elif animationStage == -1:
		$DoorClosed.visible = true
		$Dialouge.say("", "Who's behind this door?")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 0
			$DoorClosed.visible = false
			$Dialouge.hide_dialouge()
