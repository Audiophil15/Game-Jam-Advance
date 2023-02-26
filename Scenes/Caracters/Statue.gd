extends StaticBody2D

signal powerActivated

export var statueID : int
var isPlayerNearby
var powerAvailable

func _ready():
	self.z_index = int(self.position.y)
	isPlayerNearby = false
	powerAvailable = true

func _process(delta):
#	print(isPlayerNearby, powerAvailable)
	if isPlayerNearby and powerAvailable and Input.is_action_just_pressed("ui_accept") :
		emit_signal("powerActivated", statueID)
		print("Signal emitted") #DEBUG
		powerAvailable = false

func bodyEntered(body) :
#	print("Entered ", body) #DEBUG
	if body != self :
		isPlayerNearby = true

func bodyExited(body):
	isPlayerNearby = false
