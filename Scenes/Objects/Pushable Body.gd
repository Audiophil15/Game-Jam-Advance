extends KinematicBody2D

class_name Pushable

func _process(_delta):
	self.z_index = int(self.position.y)
