extends Map

signal playerIn

func onPlayerIn(body) :
	if body.get_instance_id() == $"/root/PlayerId".playerID :
		emit_signal("playerIn")

