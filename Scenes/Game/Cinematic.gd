extends Node2D

var game

func _ready():
	game = preload("res://Scenes/Game/SplashScreen.tscn")

func toSplash() :
	print("Na")
	get_tree().change_scene_to(game)
