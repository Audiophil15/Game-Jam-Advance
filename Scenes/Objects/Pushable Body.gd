extends KinematicBody2D

class_name Pushable

func _process(_delta):
	$AnimatedSprite.z_index = int(self.get_global_position().y)

func push(velocity) :
	move_and_slide(velocity)
