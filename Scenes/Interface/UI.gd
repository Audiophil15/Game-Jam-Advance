extends Control

func _ready():
	$"Character Text/MarginContainer/MarginContainer/HBoxContainer/Label".align = Label.ALIGN_LEFT
	$"Character Text/MarginContainer/MarginContainer/HBoxContainer/Label".valign = Label.VALIGN_TOP
	$"Narrator Text/MarginContainer/MarginContainer/HBoxContainer/Label".align = Label.ALIGN_CENTER
	$"Narrator Text/MarginContainer/MarginContainer/HBoxContainer/Label".valign = Label.VALIGN_CENTER
