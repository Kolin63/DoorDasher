extends Node2D
var car_scene = preload("res://car.tscn")
var distanceTimeSeconds = 0 
var distanceMaxSeconds = 1
var playerAlive
signal playerDied
signal road_complete
var dialougeClosed


func setup(maxSeconds):
	dialougeClosed = false
	playerAlive = true
	distanceTimeSeconds = 0
	distanceMaxSeconds = maxSeconds
	$Dialouge.show_dialouge()
	$Dialouge.say("", "New Order Received!\nPlotting Course...")


func _process(delta):
	if playerAlive:
		$Player.subwayMove()
	$ProgressBar/ColorRect.size.y = distanceTimeSeconds / distanceMaxSeconds * 540
	if !dialougeClosed:
		if Input.is_action_just_pressed("left_click"):
			dialougeClosed = true
			$Dialouge.hide_dialouge()
			$CarSpawnTimer.start()
	else:
		after_dialouge(delta)



func after_dialouge(delta):
	if distanceTimeSeconds <= distanceMaxSeconds && playerAlive:
		distanceTimeSeconds += 1 * delta
	if distanceTimeSeconds >= distanceMaxSeconds - 5:
		$CarSpawnTimer.stop()
	if distanceTimeSeconds >= distanceMaxSeconds:
		$Dialouge.say("", "Destination Arrived!")
		if Input.is_action_just_pressed("left_click"):
			road_complete.emit()
		
	
	

func _on_car_spawn_timer_timeout():
	for i in 2:
		var car = car_scene.instantiate()
		car.visible = true
		car.position.x = -105
		car.set_lane(randi_range(-1, 1))
		if car._lane < 0:
			car._lane = -1
			car.position.y = 540
		elif car._lane == 0:
			car.position.y = 324
		elif car._lane > 0:
			car._lane = 1
			car.position.y = 108
		car.set_texture("car")
		
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
