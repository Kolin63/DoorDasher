extends Node2D
var car_scene = preload("res://car.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$CarSpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_car_spawn_timer_timeout():
	print("new car")
	var car = car_scene.instantiate()
	add_child(car)

