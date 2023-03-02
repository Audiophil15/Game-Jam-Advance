extends Control

func _ready():
	$AnimationPlayer.play("End")
	$Music.play()
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(_anim_name):
	get_tree().quit()
	pass # Replace with function body.
