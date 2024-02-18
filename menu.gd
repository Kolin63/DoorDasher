extends Node2D
signal load_road
var seconds = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$top.visible = false
	$Logo.visible = false
	$bottom.visible = false
	$start.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seconds += delta
	if seconds >= 2:
		$top.visible = true
	if seconds >= 3.5:
		$Logo.visible = true
	if seconds >= 4:
		$bottom.visible = true
	if seconds >= 5.8:
		$start.visible = true
	
	
	if Input.is_action_just_pressed("left_click"):
		load_road.emit()
