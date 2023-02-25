extends AudioStreamPlayer

var minVol = -40

func fadein(audioNode, from = minVol, to = 0) :
	var fadein = $Tween
	fadein.interpolate_property(audioNode, "volume_db", from, to, 0.4)
	fadein.start()

func fadeout(audioNode):
	var fadeout = $Tween
	fadeout.interpolate_property(audioNode, "volume_db", audioNode.volume_db, minVol, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	fadeout.start()
