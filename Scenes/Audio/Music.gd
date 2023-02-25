extends AudioStreamPlayer

var minVol = -40

func _ready():
	self.play()
	$".".fadein(self)
