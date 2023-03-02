extends Control

var mapsize
var screensize
var camLimitXinf
var camLimitXsup
var camLimitYinf
var camLimitYsup

var allstatues = 0

var endanim

func _ready():
	mapsize = Vector2(1740,936) #$"Forest".dimensions
	screensize = $".".rect_size
	camLimitXinf = screensize.x*$Camera2D.zoom.x/2
	camLimitXsup = mapsize.x-camLimitXinf
	camLimitYinf = screensize.y*$Camera2D.zoom.y/2
	camLimitYsup = mapsize.y-camLimitYinf
	$Pause.enableNextText()

	$Pause/Node2D.scale = $Camera2D.zoom

	endanim = preload("res://Scenes/Game/End Animation.tscn")


#	$Player.learnSwim()

func _process(_delta):
	$Player.position.x = clamp($Player.position.x, 0, mapsize.x)
	$Player.position.y = clamp($Player.position.y, 0, mapsize.y)
	$Camera2D.position = $Player.position
	$Camera2D.position.x = clamp($Camera2D.position.x, camLimitXinf, camLimitXsup)
	$Camera2D.position.y = clamp($Camera2D.position.y, camLimitYinf, camLimitYsup)

	$Pause.rect_position = $Camera2D.position-screensize*$Camera2D.zoom.x/2

	if Input.is_action_just_pressed("pause") :
		if not get_tree().paused :
			get_tree().paused = true
			$Pause.show()
		else :
			get_tree().paused = false
			$Pause.hide()


func _on_Statue_powerActivated(statueID):
	if statueID == 1 :
		$Player.learnClimb()
	if statueID == 2 :
		$Player.learnDash()
	if statueID == 3 :
		allstatues = 1
		$Player.learnSwim()

	$Pause.enableNextText()

func onPlayerInsideCentre() :
	if allstatues :
		endgame()

func endgame():
	$SceneFader.shader_fade_out(self)
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene_to(endanim)

func _on_mvp(position):
	$Player.position = position
