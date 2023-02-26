extends Node2D

signal mvp(position)

func _ready():
	pass

func _on_Portal_in_body_entered(body, id):
	var out
	out = "A"
	if "A" in id :
		out = "B"

	get_node("Portal %s/Portal%s - in" % [out, out]).monitoring = false
	yield(get_tree().create_timer(0.2), "timeout")
	emit_signal("mvp", get_node("Portal %s" %out).get_global_position())
	print("tp sigsent ", id)


func _on_Portal_out_body_exited(body, id):
	var p = "A"
	if "B" in id :
		p = "B"
	get_node("Portal %s/Portal%s - in" % [p, p]).monitoring = true
	print("body out of %s ok"%id)
