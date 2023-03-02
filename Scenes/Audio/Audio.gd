extends AudioStreamPlayer

signal fadeEnded

var minVol = -80
var defaultDuration = 2

#func fade(from = minVol, to = 0, duration = defaultDuration) :
#	var animation = $Fader.get_animation("Fade")
##	animation.track_insert_key(0, 0, from)
##	animation.track_insert_key(0, duration, to)
#	animation.length = duration
#	animation.track_set_key_time(0, 1, duration)
#	animation.track_set_key_value(0, 0, from)
#	animation.track_set_key_value(0, 1, to)
#	$Fader.play("Fade")

func fadeout(_duration = defaultDuration):
#	fade(0, minVol, duration)
#	$Fader.play("Fade")
	$Fader.play("Fade Out")

func fadein(_duration = defaultDuration):
#	fade(minVol, 0, duration)
#	$Fader.play("Fade")
	$Fader.play("Fade In")

func _on_fade_completed():
	emit_signal("fadeEnded")


func _on_Fader_animation_finished(_anim_name):
	emit_signal("fadeEnded")
	pass # Replace with function body.
