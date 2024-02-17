extends Node2D
signal load_road
signal load_dog
signal load_fat
signal load_police
signal load_death
signal load_menu
var scene
var road_scene = preload("res://road.tscn")
var dog_scene = preload("res://FirstBossFight.tscn")
var fat_scene = preload("res://BossFightTwo.tscn")
var police_scene = preload("res://BossFight3.tscn")
var death_scene = preload("res://death_scene.tscn")
var menu_scene = preload("res://menu.tscn")


func _ready():
	_on_load_menu()


func clear_scene():
	remove_child(scene)

func _on_load_road():
	clear_scene()
	scene = road_scene.instantiate()
	add_child(scene)
	scene.playerDied.connect(_on_load_death)


func _on_load_dog():
	clear_scene()
	scene = dog_scene.instantiate()
	add_child(scene)


func _on_load_fat():
	clear_scene()
	scene = fat_scene.instantiate()
	add_child(scene)


func _on_load_police():
	clear_scene()
	scene = police_scene
	add_child(scene)


func _on_load_death():
	clear_scene()
	scene = death_scene.instantiate()
	add_child(scene)


func _on_load_menu():
	clear_scene()
	scene = menu_scene.instantiate()
	add_child(scene)
	scene.load_road.connect(_on_load_road)
