extends Node2D

export var dimensions : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	self.dimensions = $Forest.dimensions


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print("RAH")
#	pass
