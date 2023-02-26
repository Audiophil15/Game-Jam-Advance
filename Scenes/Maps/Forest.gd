extends Map

var activatedSwitches

func _ready():
	self.dimensions = Vector2(216, 360)
	activatedSwitches = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activatedSwitches == 2 :
		$Door/Sprite.play("opening")
		$Door.collision_layer = 0
		$Door.collision_mask = 0

func _on_Switch_body_entered(body):
	activatedSwitches += 1

func _on_Switch_body_exited(body):
	activatedSwitches -= 1
