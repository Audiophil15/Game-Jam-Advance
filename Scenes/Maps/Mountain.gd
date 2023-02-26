extends Node2D

signal mvp(position)

func _ready():
	self.dimensions = Vector2()



func _on_Portal_in_body_entered(body, side):
	if side == "A" :
		emit_signal("mvp", $"Portal B".position)
		$

