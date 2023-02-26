extends KinematicBody2D

var defaultSpeed
var dashSpeed
var pushSpeed
var climbSpeed
var swimSpeed

var isDashing
var isSwimming
var isClimbing
var isPushing
var velocity
var collided

var direction
var movetype

var dashTestBodiesCounter
var dashStartPos

var isabletoPush
var isabletoDash
var isabletoClimb
var isabletoSwim

var sndDash
var sndSwim
var sndStepForest
var sndStepGrt
var sndStepSand
var sndPlouf


"""
Masks :
	1 Plain wall
	2 Dashable gap
	3 Climbable cliff
	4 Swimable water
	5 Pushable object
"""

func _ready():
	defaultSpeed = 50
	dashSpeed = 5*defaultSpeed
	pushSpeed = 0.2*defaultSpeed
	swimSpeed = 0.6*defaultSpeed
	climbSpeed = 0.5*defaultSpeed

	isDashing = 0
	isSwimming = 0
	isClimbing = 0
	isPushing = 0
	velocity = Vector2()
	dashTestBodiesCounter = 0

	direction = "Down"
	movetype = "Idle"

	isabletoPush = 1
	isabletoDash = 0
	isabletoClimb = 0
	isabletoSwim = 0

	sndDash = "res://Audio/Sounds/Dash_v1.wav"
	sndSwim = "res://Audio/Sounds/Nage_v1.wav"
	sndStepForest = "res://Audio/Sounds/pas_forêt_v1.wav"
	sndStepGrt = "res://Audio/Sounds/pas_grotte_v1.wav"
	sndStepSand = "res://Audio/Sounds/pas_sable_v1.wav"
	sndPlouf = "res://Audio/Sounds/Plouf_v1.wav"

	$Audio.stream = load(sndPlouf)

#	learnDash()
#	learnSwim()
#	learnClimb()

func _process(_delta):

	self.z_index = int(self.position.y)

	if not isDashing :
		velocity = Vector2()
		if Input.is_action_pressed("ui_right") :
			direction = "Right"
			velocity.x += 1
		if Input.is_action_pressed("ui_left") :
			direction = "Left"
			velocity.x -= 1
		if Input.is_action_pressed("ui_up") :
			direction = "Up"
			velocity.y -= 1
		if Input.is_action_pressed("ui_down") :
			direction = "Down"
			velocity.y += 1
	if isabletoDash and not isSwimming and not isClimbing and Input.is_action_just_pressed("dash") :
		dash()
	if velocity.length() > 0 :
		movetype = "Walk"
		if isDashing :
			movetype = "Dash"
		if isSwimming :
			movetype = "Swim"
		if isClimbing :
			movetype = "Climb"
			direction = "Up"
		if isPushing :
			movetype = "Push"

	else :
		movetype = "Idle"
		if isSwimming :
			movetype = "Swim"

	if velocity.x < 0 :
		$Sprite.flip_h = true
	if velocity.x > 0 :
		$Sprite.flip_h = false

	animate($Sprite, movetype, direction)

	collided = move_and_slide(velocity.normalized() * (defaultSpeed if not (isDashing or isSwimming or isClimbing) else (isDashing*dashSpeed + isSwimming*swimSpeed + isClimbing*climbSpeed)))
	if isabletoPush :
		checkPushing()

func animate(spriteNode, type, dir) :
	spriteNode.play(type+" "+dir)

func dash() :
	isDashing = 1
	dashStartPos = self.position
	self.set_collision_mask_bit(1,0) # Remove bit 2
	self.set_collision_mask_bit(2,1)
	yield(get_tree().create_timer(0.3), "timeout")
	if dashTestBodiesCounter :
		# Timeout pour l'anim de noyade/chute
		if not isSwimming :
			self.position = dashStartPos
	self.set_collision_mask_bit(1,1) # Remove bit 2
	if isabletoClimb :
		self.set_collision_mask_bit(2,0)
	isDashing = 0

func _on_Testbody_body_entered(body):
#	print(body) # DEBUG
	if body != self :
		dashTestBodiesCounter += 1
	if body.is_in_group("Water") :
		$Audio.play()
#		print("Swimming") #DEBUG
		isSwimming = 1
	if body.is_in_group("Cliff") :
		isClimbing = 1

func _on_Testbody_body_exited(body):
	if body != self :
		dashTestBodiesCounter -= 1
#		print("Exited") #DEBUG
		isSwimming = 0
		isClimbing = 0

func checkPushing():
	isPushing = 0
	if get_slide_count() > 0 :
		if not(velocity.dot(Vector2(0,1)) and velocity.dot(Vector2(1,0))) :
			var object = get_slide_collision(0).collider
			if object.is_in_group("Pushable") :
				object.push(velocity*pushSpeed)
				isPushing = 1

func learnDash() :
	isabletoDash = 1

func learnClimb() :
	isabletoClimb = 1
	self.set_collision_mask_bit(2,0) # Remove bit 3

func learnSwim() :
	isabletoSwim = 1
	self.set_collision_mask_bit(3,0) # Remove bit 4
