extends Map

signal mvp(position)
#
#func _on_Area2D_body_entered(body):
#	emit_signal("body", body)

func _on_Tunnel_mvp(position):
	emit_signal("mvp", position)
