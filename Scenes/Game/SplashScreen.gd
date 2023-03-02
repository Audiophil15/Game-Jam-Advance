extends Control

var game

func _ready():
	game = preload("res://Scenes/Game/Main.tscn")
	self.modulate = Color(0,0,0)
	$SceneFader.shader_fade_in(self)
	$Audio.play()
	$Audio.volume_db = 0

func _on_Play_mouse_entered():
	$Tween.interpolate_property($Play/Underline, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Play_mouse_exited():
	$Tween.interpolate_property($Play/Underline, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Play_pressed():
	$Audio.fadeout()
	$SceneFader.shader_fade_out(self)
	yield($SceneFader, "completed")
	$Audio.stop()
	get_tree().change_scene_to(game)
