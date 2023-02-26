extends Control

var mapsize
var screensize
var camLimitXinf
var camLimitXsup
var camLimitYinf
var camLimitYsup

func _ready():
	mapsize = $Map.dimensions
	screensize = $".".rect_size
	camLimitXinf = screensize.x*$Camera2D.zoom.x/2
	camLimitXsup = mapsize.x-camLimitXinf
	camLimitYinf = screensize.y*$Camera2D.zoom.y/2
	camLimitYsup = mapsize.y-camLimitYinf

func _process(_delta):
	$Player.position.x = clamp($Player.position.x, 0, mapsize.x)
	$Player.position.y = clamp($Player.position.y, 0, mapsize.y)
	$Camera2D.position = $Player.position
	$Camera2D.position.x = clamp($Camera2D.position.x, camLimitXinf, camLimitXsup)
	$Camera2D.position.y = clamp($Camera2D.position.y, camLimitYinf, camLimitYsup)

	if Input.is_action_just_pressed("pause") :
		get_tree().paused = not get_tree().paused


func _on_Statue_powerActivated(statueID):
	var power
	if statueID == 1 :
		$Player.learnDash()
		power = "accélérer"
	if statueID == 2 :
		$Player.learnClimb()
		power = "escalader des falaises"
	if statueID == 3 :
		$Player.learnSwim()
		power = "nager"

	get_tree().paused = true
	characterMessage("Statue %d" % statueID, "Bienvenue, mon ami.")
	characterMessage("Statue %d" % statueID, "Voici qui t'aidera dans ta quête...")
	yield($"UI/Character Text", "noQueue")
	interfaceMessage("Vous pouvez désormais %s !" % power)
	yield($"UI/Narrator Text", "noQueue")
	get_tree().paused = false

func characterMessage(characterName, msg) :
	$"UI/Character Text".queueText(characterName+" :\n"+msg)

func interfaceMessage(msg) :
	$"UI/Narrator Text".queueText(msg)
