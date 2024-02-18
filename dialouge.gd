extends Control


func say(name, text):
	show_dialouge()
	if name == "":
		$NameBackground.visible = false
	$Dialouge.text = text
	$Name.text = name


func show_dialouge():
	$Dialouge.visible = true
	$Name.visible = true
	$Background.visible = true
	$NameBackground.visible = true
	$Instructions.visible = true
	$InstructionsBackground.visible = true
	

func hide_dialouge():
	$Dialouge.visible = false
	$Name.visible = false
	$Background.visible = false
	$NameBackground.visible = false
	$Instructions.visible = false
	$InstructionsBackground.visible = false
