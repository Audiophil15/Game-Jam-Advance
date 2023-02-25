extends StaticBody2D

signal powerActivated

export var statueID : int
var isPlayerNearby
var powerAvailable

func _ready():
	isPlayerNearby = false
	powerAvailable = true

func _process(delta):
#	print()
	if isPlayerNearby and powerAvailable and Input.is_action_just_pressed("ui_accept") :
		emit_signal("powerActivated", statueID)
		print("Signal emitted") #DEBUG
		powerAvailable = false
	pass

func playerEntered() :
	isPlayerNearby = true

func playerExited():
	isPlayerNearby = false
