extends Map

signal mvp(position)
signal body(body)

var activatedSwitches
var hasplayed = 0

func _ready():
	self.dimensions = Vector2(936, 312)
	$Audio.play()
	$Music.play()
	$Music.fadein(-35)
	$Audio.fadein(-35)
	activatedSwitches = 0

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
	emit_signal("mvp", position) # UNNEEDED

func soundToHappy() :
	$Audio.fadeout()
	$Music.fadeout()
	$Audio.stream = load("res://Audio/Ambiances/Forêt_joyeuse.wav")
	$Music.stream = load("res://Audio/Musics/Forest_happy.wav")
	$Audio.play()
	$Music.play()
	$Audio.fadein()
	$Music.fadein(-35)


func _on_Area2D_body_entered(body):
	emit_signal("body", body)
