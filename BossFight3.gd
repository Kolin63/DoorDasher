extends AnimatedSprite2D
var car_scene = preload("res://car.tscn")
var distanceTimeSeconds
var distanceMaxSeconds
var playerAlive
signal playerDied
signal road_complete
signal remove_pineapple(removeLane)
var dialouge_closed
var pineapples_top = 0
var pineapples_middle = 0
var pineapples_bottom = 0
var time_since_last_shot = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialouge.say("", "Pineapple launcher equipped.\nPress and hold space or left-click to fire.")
	$ProgressBar/ColorRect.size.y = 0
	dialouge_closed = false
	playerAlive = true
	distanceTimeSeconds = 0.0
	distanceMaxSeconds = 30  
	$Dog.play()


func _process(delta):
	if dialouge_closed:
		after_dialouge(delta)
	else:
		if Input.is_action_just_pressed("left_click"):
			dialouge_closed = true
			$Dialouge.hide_dialouge()
			$PooSpawnTimer.start()


func after_dialouge(delta):
	$ProgressBar/ColorRect.size.y = distanceTimeSeconds / distanceMaxSeconds * 540
	
	if distanceTimeSeconds >= distanceMaxSeconds:
		$Dog.stop()
		$Dog.lane = 0
		$RoadSprite.speed = 0
		$Dialouge.show_dialouge()
		$Dialouge.say("Pizza Police", "The pineapples...\nThey are too strong...\nI can't handle it anymore.")
		$Player/AnimatedSprite2D.stop()
		if Input.is_action_just_pressed("left_click"):
			road_complete.emit()
	
	
	if distanceTimeSeconds <= distanceMaxSeconds && playerAlive:
		if Input.is_action_pressed("left_click") && time_since_last_shot >= 0.25 || Input.is_action_just_pressed("left_click"):
			time_since_last_shot = 0
			var car = car_scene.instantiate()
			car.visible = true
			car.position.x = $Player.position.x
			car.set_lane($Player.lane)
			if car._lane < 0:
				pineapples_bottom += 1
				car._lane = -1
				car.position.y = 540
			elif car._lane == 0:
				pineapples_middle += 1
				car.position.y = 324
			elif car._lane > 0:
				pineapples_top += 1
				car._lane = 1
				car.position.y = 108
			car.set_texture("pineapple")
			
			add_child(car)
			car.police_death.connect(_on_police_death)
	
	
	if distanceTimeSeconds >= distanceMaxSeconds:
		$PooSpawnTimer.stop()
	
	if playerAlive:
		$Player.subwayMove()
	
	if distanceTimeSeconds > distanceMaxSeconds:
		distanceTimeSeconds = distanceMaxSeconds
	$ProgressBar/ColorRect.size.y = distanceTimeSeconds / distanceMaxSeconds * 540
	
	time_since_last_shot += delta

func _on_poo_spawn_timer_timeout():
	var car = car_scene.instantiate()
	car.visible = true
	car.position.x = $Dog.position.x
	var carLane = randi_range(-1, 1)
	if carLane == 1 && pineapples_top > 3:
		carLane = randi_range(-1, 0)
	elif carLane == 0 && pineapples_middle > 3:
		carLane = randi_range(-1, 0)
		if carLane == 0:
			carLane = 1
	elif carLane == -1 && pineapples_bottom > 3:
		carLane = randi_range(0, 1)
	car.set_lane(carLane)
	
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
	car.set_texture("pizza")
	
	add_child(car)
	car.death.connect(_on_car_death)



func _on_car_death(carLane):
	if carLane == $Player.lane && time_since_last_shot >= 0.5:
		$RoadSprite.speed = 0
		$Player/AnimatedSprite2D.animation = "death"
		playerAlive = false
		$DeathTransitionTimer.start()


func _on_police_death(carLane):
	if carLane == $Dog.lane:
		distanceTimeSeconds += 1


func _on_death_transition_timer_timeout():
	playerDied.emit()


func _on_pineapple_checker_area_entered(area):
	if area._lane == 1:
		pineapples_top -= 1
	elif area._lane == 0:
		pineapples_middle -= 1
	elif area._lane == -1:
		pineapples_bottom -= 1
