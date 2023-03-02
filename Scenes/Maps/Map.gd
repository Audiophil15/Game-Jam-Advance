extends Node2D

class_name Map

signal powerActivated(statueID)

enum mood {Sad, Happy}
var currentMood

var dimensions : Vector2

func _ready():
	dimensions = Vector2(2542, 1517)
	$Statue.z_index = $Statue.get_global_position().y
	$"Sad Ambiance".play()
	$"Sad Music".play()
	$"Happy Ambiance".play()
	$"Happy Music".play()
	currentMood = mood.Sad
#	audioFadein()

#func _process(delta):
#	if Input.is_action_just_pressed("ui_down") :
#		_on_Statue_powerActivated()

func setAmbiance(m : int) :
	currentMood = m

func audioFadeout() :
	if currentMood == mood.Sad :
		$"Sad Music".fadeout()
		$"Sad Ambiance".fadeout()
	if currentMood == mood.Happy :
		$"Happy Ambiance".fadeout()
		$"Happy Music".fadeout()

func audioFadein() :
	if currentMood == mood.Sad :
		$"Sad Music".fadein()
		$"Sad Ambiance".fadein()
	if currentMood == mood.Happy :
		$"Happy Music".fadein()
		$"Happy Ambiance".fadein()



func _on_Statue_powerActivated():
	audioFadeout()
	setAmbiance(mood.Happy)
	audioFadein()
	emit_signal("powerActivated", $Statue.statueID)


func _on_body_entered(body):
	if body.get_instance_id() == $"/root/PlayerId".playerID :
		audioFadein()

func _on_body_exited(body):
	if body.get_instance_id() == $"/root/PlayerId".playerID :
		audioFadeout()
