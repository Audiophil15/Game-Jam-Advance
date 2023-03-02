extends Control

var label
var currentlabel
var labeltoshow
var i
var showlabels

var labels

func _ready():
	labels = ["La météorite vous aura imposé de stopper le temps pour un moment. Vous décidez de partir à la rencontre des anciens sages, quérir auprès d'eux une aide nécessaire...", "Herolrec n'a pas su trouver de solution, mais il vous a néanmoins conseillé de vous rendre auprès de Mylanzer le Montagnard, qui en sait plus que lui.", "Il ne restait de Mylanzer qu'une statue, qui récompensa votre courage d'avoir bravé la montagne en vous faisant don d'une rapidité inégalée. Cela ne vous permettra pas d'échapper à la météorite, mais cette nouvelle puissance vous donne l'idée d'une prochaine destination, car il existe en ce monde une troisième source de sagesse.", "L'Ancien sage Lorich vous a fait comprendre qu'aucun sage ne sera en mesure de vous aider. Malgré tous vos efforts, vous êtes maintenant sans recours. Ou du moins, c'est l'impression que vous avez..."]
	currentlabel = 0
	labeltoshow = 0
	i = 0

func _process(_delta):
	if self.modulate == Color(1,1,1,1) and showlabels and currentlabel<labeltoshow:
		label = get_node("Node2D/Label%d"%currentlabel)
		label.set_bbcode("[center][fade start="+str(i)+" length=10]" + labels[currentlabel] + "[/fade][/center]")
		i+=0.5
		if i >  label.text.length()+20 :
			i = 0
			currentlabel += 1

func show() :
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	showlabels = 1


func hide() :
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	showlabels = 0
#	for i in range(4) :
#		get_node("Node2D/Label%d"%i).set_bbcode("")

func enableNextText() :
	labeltoshow += 1
