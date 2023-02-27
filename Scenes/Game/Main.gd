extends Control

var mapsize
var screensize
var camLimitXinf
var camLimitXsup
var camLimitYinf
var camLimitYsup

var ambS
var ambH
var musS
var musH
var happyzones = [0,0,0,0]

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

	ambS = [preload("res://Audio/Ambiances/Zone 1_v2_début.wav"), preload("res://Audio/Ambiances/Forêt_sombre.wav"), preload("res://Audio/Ambiances/Montagne_sombre_v1.wav"), preload("res://Audio/Ambiances/Plage_sombre_v2.wav")]
	ambH = [preload("res://Audio/Ambiances/Zone 1__v1_fin.wav"), preload("res://Audio/Ambiances/Forêt_joyeuse.wav"), preload("res://Audio/Ambiances/Montagne_joyeuse_v1.wav"), preload("res://Audio/Ambiances/Plage_joyeuse.wav")]
	musS = [preload("res://Audio/Musics/Central sad.wav"), preload("res://Audio/Musics/Forest_sad+.wav"), preload("res://Audio/Musics/Mountain_sad .wav"), preload("res://Audio/Musics/Beach_sad.wav")]
	musH = [preload("res://Audio/Musics/Central_happy.wav"), preload("res://Audio/Musics/Forest_happy.wav"), preload("res://Audio/Musics/Mountain_happy.wav"), preload("res://Audio/Musics/Beach_happy.wav")]
#	$Pause/Node2D.scale = $Camera2D.zoom

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
	var power
	if statueID == 2 :
		$Player.learnClimb()
		power = "escalader des falaises"
	if statueID == 3 :
		$Player.learnDash()
		power = "accélérer"
	if statueID == 4 :
		allstatues = 1
		$Player.learnSwim()
		power = "nager"

	get_node("Statue%d/Sprite"%(statueID-1)).frame = 1
	happyzones[statueID-1] = 1
	$Pause.enableNextText()

	get_tree().paused = true
	characterMessage("Statue %d" % (statueID-1), "Bienvenue, mon ami.")
	characterMessage("Statue %d" % (statueID-1), "Voici qui t'aidera dans ta quête...")
	yield($"UI/Character Text", "noQueue")
	interfaceMessage("Vous pouvez désormais %s !" % power)
	yield($"UI/Narrator Text", "noQueue")
	get_tree().paused = false

	print("statueID ", statueID)
	happyzones[statueID-1] = 1
	changemusic(statueID)

#	get_node("Zone %d"%statueID).soundToHappy()

func characterMessage(characterName, msg) :
	$"UI/Character Text".queueText(characterName+" :\n"+msg)

func interfaceMessage(msg) :
	$"UI/Narrator Text".queueText(msg)

func bodyEnteredMap(body, zone):
	if body == $Player :
#		$Amb.fadeout()
#		$Music.fadeout()
		changemusic(zone)

func changemusic(zone):
	$Amb.stop()
	$Music.stop()
	if allstatues and zone == 1 :
		$Amb.fadeout()
		$Music.fadeout()
		$Amb.stop()
		$Music.stop()
		$SceneFader.shader_fade_out(self)
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().change_scene_to(endanim)

	if happyzones[zone-1] :
		$Amb.stream = ambH[zone-1]
		$Music.stream = musH[zone-1]
	else :
		$Amb.stream = ambS[zone-1]
		$Music.stream = musS[zone-1]

	if not $Amb.playing :
		$Amb.play()
		$Music.play()
	$Amb.fadein()
	$Amb.fadein()


func _on_mvp(position):
	$Player.position = position
