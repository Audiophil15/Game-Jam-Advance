extends Control

var splashScreen = preload("res://Scenes/Game/SplashScreen.tscn")
var mainGame = preload("res://Scenes/Game/Main.tscn")
#var pauseScreen = preload("res://Scenes/Game/PauseScreen.tscn")
#var endScreen = preload("res://Scenes/Game/EndScreen.tscn")

func changeScene(scene) :
	get_tree().
