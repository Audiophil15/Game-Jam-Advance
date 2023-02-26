extends Map

signal mvp(position)

var activatedSwitches
var hasplayed = 0

func _ready():
	self.dimensions = Vector2(936, 312)
	$Audio.play()
	$Audio.fadein(-35)
	activatedSwitches = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activatedSwitches == 2 :
		$Door/Sprite.play("opening")
		if not $Door/Audio.playing and not hasplayed :
			hasplayed = 1
			$Door/Audio.play()
		$Door.collision_layer = 0
		$Door.collision_mask = 0

func _on_Switch_body_entered(body):
	activatedSwitches += 1

func _on_Switch_body_exited(body):
	activatedSwitches -= 1

func _on_Tunnel_mvp(position):
	emit_signal("mvp", position)
	pass # Replace with function body.
