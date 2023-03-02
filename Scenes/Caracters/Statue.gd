extends StaticBody2D

class_name Statue

signal powerActivated

export var statueID : int
export var message : Array
export var power : String
var isPlayerNearby
var powerAvailable

func _ready():
	self.z_index = int(self.position.y)
	isPlayerNearby = false
	powerAvailable = true

func _process(_delta):
	if isPlayerNearby and powerAvailable and Input.is_action_just_pressed("ui_accept") :
		activatePower()

func activatePower() :
	powerAvailable = false
	get_tree().paused = true
	for line in message :
		$UI.characterMessage("Statue %d"%statueID, line)
	yield($"UI/Character Text", "noQueue")
	$UI.interfaceMessage("Vous pouvez désormais %s !" % power)
	yield($"UI/Narrator Text", "noQueue")
	$Sprite.play("On")
	get_tree().paused = false
	emit_signal("powerActivated")

func bodyEntered(body) :
#	print("Entered ", body) #DEBUG
	if body.get_instance_id() == $"/root/PlayerId".playerID :
		isPlayerNearby = true

func bodyExited(_body):
	isPlayerNearby = false
