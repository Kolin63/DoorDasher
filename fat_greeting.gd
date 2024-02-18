extends Node2D
var animationStage
signal load_fat


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialouge.hide_dialouge()
	$fat.position = Vector2(1281, 350)
	animationStage = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animationStage == 4:
		$Dialouge.say("Fatty McFatFace", "YOU WILL PAY FOR THIS!!!!")
		if Input.is_action_just_pressed("left_click"):
			$Dialouge.hide_dialouge()
			load_fat.emit()
	elif animationStage == 3:
		$Dialouge.show_dialouge()
		$Dialouge.say("Fatty McFatFace", "Let's see, 5033, 5034...\nYOU'RE MISSING ONE! I ASKED FOR 5035!")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 4
	elif animationStage == 2:
		$Dialouge.show_dialouge()
		$Dialouge.say("Fatty McFatFace", "But don't leave yet! I need to count how many pizzas are here.\nYou would not BELIEVE how many people didn't bring \nthe proper amount of pies.")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 3
	elif animationStage == 1:
		$Dialouge.show_dialouge()
		$Dialouge.say("Fatty McFatFace", "Finally, my pizzas are here!")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 2
	elif animationStage == 0:
		$fat.position.x -= 400 * delta
		if $fat.position.x <= 700:
			animationStage = 1
		if Input.is_action_just_pressed("left_click"):
			$fat.position.x = 700
	elif animationStage == -1:
		$Dialouge.show_dialouge()
		$DoorClosed.visible = true
		$Dialouge.say("", "Who's behind this door?")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 0
			$DoorClosed.visible = false
			$Dialouge.hide_dialouge()

