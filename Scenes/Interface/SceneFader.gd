extends Control

signal completed

func shader_fade_out(rootnode):
	var fadeout = $Tween
	fadeout.interpolate_property(rootnode, "modulate", Color(1,1,1), Color(0,0,0), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	fadeout.start()

func shader_fade_in(rootnode):
	var fadeout = $Tween
	fadeout.interpolate_property(rootnode, "modulate", Color(0,0,0), Color(1,1,1), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	fadeout.start()


func _on_Tween_all_completed():
	emit_signal("completed")
