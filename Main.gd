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

func _on_Statue_powerActivated(statueID):
	var power
	if statueID == 0 :
		$Player.learnDash()
		power = "accélérer"
	if statueID == 1 :
		$Player.learnClimb()
		power = "escalader des falaises"
	if statueID == 0 :
		$Player.learnSwim()
		power = "nager"

	message("Bienvenue, mon ami.")
	message("Voici qui t'aidera dans ta quête...")
	message("Vous pouvez désormais %s !" % power)
	yield($UI/Textbox, "noQueue")

func message(msg) :
	$UI/Textbox.queueText(msg)
	$UI/Textbox.queueText("Bienvenue, mon ami.")
	$UI/Textbox.queueText("Voici qui t'aidera dans ta quête...")
	$UI/Textbox.queueText("Bienvenue, mon ami.")
