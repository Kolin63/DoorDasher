extends AnimatedSprite2D
var car_scene = preload("res://car.tscn")
var distanceTimeSeconds
var distanceMaxSeconds
var playerAlive
signal playerDied
signal road_complete


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dog.play()
	$Dialouge.hide_dialouge()
	playerAlive = true
	distanceTimeSeconds = 0
	distanceMaxSeconds = 45
	$PooSpawnTimer.start()


func _process(delta):
	if distanceTimeSeconds >= distanceMaxSeconds:
		$Dog.stop()
		$Dog.lane = 0
		$RoadSprite.speed = 0
		$Dialouge.show_dialouge()
		$Dialouge.say("Dog", "Whoo! That was tiring. Anyways, its time for my nap. Cya! ")
		$Player/AnimatedSprite2D.stop()
		if Input.is_action_just_pressed("left_click"):
			road_complete.emit()
	
	
	if distanceTimeSeconds <= distanceMaxSeconds && playerAlive:
		distanceTimeSeconds += 1 * delta
	if distanceTimeSeconds >= distanceMaxSeconds - 7:
		$PooSpawnTimer.stop()
	
	if playerAlive:
		$Player.subwayMove()
	$ProgressBar/ColorRect.size.y = distanceTimeSeconds / distanceMaxSeconds * 540

func _on_poo_spawn_timer_timeout():
	var car = car_scene.instantiate()
	car.visible = true
	car.position.x = -105
	car.set_lane(randi_range(-1, 1))
	if car._lane < 0:
		car._lane = -1
		car.position.y = 540
		if $Dog.lane != -1:
			$Dog.laneOffset = -216
		$Dog.lane = -1
	elif car._lane == 0:
		car.position.y = 324
		if $Dog.lane == -1:
			$Dog.laneOffset = 216
		elif $Dog.lane == 1:
			$Dog.laneOffset = -216
		$Dog.lane = 0
	elif car._lane > 0:
		car._lane = 1
		car.position.y = 108
		if $Dog.lane != 1:
			$Dog.laneOffset = 216
		$Dog.lane = 1
	car.set_texture("poop")
	
	add_child(car)
	car.death.connect(_on_car_death)



func _on_car_death(carLane):
	if carLane == $Player.lane:
		$RoadSprite.speed = 0
		$Player/AnimatedSprite2D.animation = "death"
		playerAlive = false
		$DeathTransitionTimer.start()


func _on_death_transition_timer_timeout():
	playerDied.emit()
