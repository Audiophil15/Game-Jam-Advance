extends Node2D

signal body(body)

func _on_Area2D_body_entered(body):
		emit_signal("body", body)
