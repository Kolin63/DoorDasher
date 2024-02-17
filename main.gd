extends Node2D
var scene
var road_scene = preload("res://road.tscn")

var dog_scene = preload("res://FirstBossFight.tscn")
var dog_greeting = preload("res://dog_greeting.tscn")

var fat_scene = preload("res://BossFightTwo.tscn")
var fat_greeting = preload("res://fat_greeting.tscn")

var police_scene = preload("res://BossFight3.tscn")
var police_greeting = preload("res://police_greeting.tscn")

var death_scene = preload("res://death_scene.tscn")
var menu_scene = preload("res://menu.tscn")


var road_stage


func _ready():
	_on_load_menu()
	road_stage = 6


func _process(_delta):
	if Input.is_action_just_pressed("skip_road"):
		_on_road_complete()


func clear_scene():
	remove_child(scene)

func _on_load_road():
	clear_scene()
	scene = road_scene.instantiate()
	add_child(scene)
	scene.playerDied.connect(_on_load_death)
	scene.road_complete.connect(_on_road_complete)
	if road_stage == 1:
		scene.setup(20)
	elif road_stage == 2:
		_on_load_dog_greeting()
	elif road_stage == 3:
		scene.setup(30)
	elif road_stage == 4:
		_on_load_fat_greeting()
	elif road_stage == 5:
		scene.setup(40)
	elif road_stage == 6:
		_on_load_police_greeting()
	elif road_stage == 7:
		_on_load_menu()
	


func _on_road_complete():
	road_stage += 1
	if road_stage == 2:
		_on_load_dog_greeting()
	elif road_stage == 3:
		_on_load_road()
	elif road_stage == 4:
		_on_load_fat_greeting()
	elif road_stage == 5:
		_on_load_road()
	elif road_stage == 6:
		_on_load_police_greeting()
	elif road_stage == 7:
		_on_load_menu()



func _on_load_dog():
	clear_scene()
	scene = dog_scene.instantiate()
	add_child(scene)
	scene.playerDied.connect(_on_load_death)
	scene.road_complete.connect(_on_road_complete)


func _on_load_dog_greeting():
	clear_scene()
	scene = dog_greeting.instantiate()
	add_child(scene)
	scene.load_dog.connect(_on_load_dog)


func _on_load_fat():
	clear_scene()
	scene = fat_scene.instantiate()
	add_child(scene)
	scene.playerDied.connect(_on_load_death)
	scene.road_complete.connect(_on_road_complete)
	

func _on_load_fat_greeting():
	clear_scene()
	scene = fat_greeting.instantiate()
	add_child(scene)
	scene.load_fat.connect(_on_load_fat)


func _on_load_police():
	clear_scene()
	scene = police_scene.instantiate()
	add_child(scene)
	scene.road_complete.connect(_on_road_complete)
	scene.playerDied.connect(_on_load_death)


func _on_load_police_greeting():
	clear_scene()
	scene = police_greeting.instantiate()
	add_child(scene)
	scene.load_police.connect(_on_load_police)


func _on_load_death():
	clear_scene()
	scene = death_scene.instantiate()
	add_child(scene)
	scene.load_road.connect(_on_load_road)


func _on_load_menu():
	clear_scene()
	scene = menu_scene.instantiate()
	add_child(scene)
	scene.load_road.connect(_on_load_road)
