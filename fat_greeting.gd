extends Node2D
var animationStage
signal load_fat


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialouge.hide_dialouge()
	$fat.position = Vector2(800, 350)
	animationStage = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animationStage == 4:
		$Dialouge.say("Globby", "YOU WILL PAY FOR THIS!!!!")
		if Input.is_action_just_pressed("left_click"):
			$Dialouge.hide_dialouge()
			load_fat.emit()
	elif animationStage == 3:
		$Dialouge.show_dialouge()
		$Dialouge.say("Globby", "Let's see, 5033, 5034...\nYOU'RE MISSING ONE! I ASKED FOR 5035!")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 4
	elif animationStage == 2:
		$Dialouge.show_dialouge()
		$Dialouge.say("Globby", "But don't leave yet! I need to count how many pizzas are here.\nYou would not BELIEVE how many people didn't bring \nthe proper amount of pies.")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 3
	elif animationStage == 1:
		$Dialouge.show_dialouge()
		$Dialouge.say("Globby", "Finally, my pizzas are here!")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 2
	elif animationStage == 0:
		$fat.position.x -= 400 * delta
		if $fat.position.x <= 450:
			animationStage = 1

