extends Map

var activatedSwitches
var hasplayed = 0

func _ready():
	self.dimensions = Vector2(936, 312)
	activatedSwitches = 0

func _process(_delta):
	if activatedSwitches == 2 :
		$Door/Sprite.play("opening")
		if not $Door/Audio.playing and not hasplayed :
			hasplayed = 1
			$Door/Audio.play()
		$Door.collision_layer = 0
		$Door.collision_mask = 0

func _on_Switch_body_entered(_body):
	activatedSwitches += 1

func _on_Switch_body_exited(_body):
	activatedSwitches -= 1
