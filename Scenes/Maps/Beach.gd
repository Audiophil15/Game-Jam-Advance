extends Map

signal body(body)

var activatedSwitches
var hasplayed = 0

func _ready():
	self.dimensions = Vector2(8640, 648)

func soundToHappy() :
	$Audio.fadeout()
	$Audio_music_sad.fadeout()
	$Audio_ambiance_happy.fadein()
	$Audio_music_happy.fadein()


func _on_Area2D_body_entered(body):
			emit_signal("body", body)
