extends Node2D
var animationStage
signal load_dog


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialouge.hide_dialouge()
	$Dog.position = Vector2(1071, 350)
	animationStage = -1
	$Pizza.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animationStage == 2:
		$Dialouge.say("", "The dog snatches the pizza from you and starts to run away!")
		$Pizza.visible = true
		if Input.is_action_just_pressed("left_click"):
			$Dialouge.hide_dialouge()
			load_dog.emit()
	elif animationStage == 1:
		$Dialouge.show_dialouge()
		$Dialouge.say("Dog", "Woof! That's a yummy looking pizza.")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 2
	elif animationStage == 0:
		$Dog.position.x -= 400 * delta
		if $Dog.position.x <= 700:
			animationStage = 1
		if Input.is_action_just_pressed("left_click"):
			$Dog.position.x = 700
	elif animationStage == -1:
		$DoorClosed.visible = true
		$Dialouge.say("", "Who's behind this door?")
		if Input.is_action_just_pressed("left_click"):
			animationStage = 0
			$DoorClosed.visible = false
			$Dialouge.hide_dialouge()

