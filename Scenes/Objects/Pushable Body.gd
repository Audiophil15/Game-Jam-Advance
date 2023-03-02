extends KinematicBody2D

class_name Pushable

func _ready():
	$Audio.volume_db = 0

func _process(_delta):
	$AnimatedSprite.z_index = int(self.get_global_position().y)

func push(velocity) :
	if not $Audio.playing :
		$Audio.play()
	move_and_slide(velocity)
