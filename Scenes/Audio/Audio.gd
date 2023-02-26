extends AudioStreamPlayer

class_name Audio

var minVol = -40

func fadein(from = minVol, to = 0) :
	var fadein = $Tween
	fadein.interpolate_property(self, "volume_db", from, to, 1)
	fadein.start()

func fadeout():
	var fadeout = $Tween
	fadeout.interpolate_property(self, "volume_db", self.volume_db, minVol, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	fadeout.start()
