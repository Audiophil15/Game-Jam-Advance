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
	swimSpeed = 1.1*defaultSpeed

	isDashing = false
	velocity = Vector2()
	dashTestBodiesCounter = 0

	direction = "Down"
	movetype = "Idle"

	isabletoPush = 1
	isabletoDash = 0
	isabletoClimb = 0
	isabletoSwim = 0

	learnDash()
	learnSwim()

func _process(_delta):

	self.z_index = int(self.position.y)

	if not isDashing :
		velocity = Vector2()
		if Input.is_action_pressed("ui_right") :
#			direction = "Up"
			velocity.x += 1
		if Input.is_action_pressed("ui_left") :
#			direction = "Left"
			velocity.x -= 1
		if Input.is_action_pressed("ui_up") :
#			direction = "Right"
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
		if isPushing :
			pass
#			movetype = "Push"
	else :
		movetype = "Idle"

#	for i in range(5)
#	print(self.get_collision_mask_bit())
#	print(movetype, direction) #DEBUG

	animate($Sprite, movetype, direction)

	collided = move_and_slide(velocity.normalized() * (defaultSpeed if not isDashing else dashSpeed))
	if isabletoPush :
		checkPushable()

func animate(spriteNode, type, dir) :
	spriteNode.play(type+" "+dir)

func dash() :
	isDashing = true
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
	isDashing = false

func _on_Testbody_body_entered(body):
	print(body)
	if body != self :
		dashTestBodiesCounter += 1
	if body.is_in_group("Water") :
		print("Swimming") #DEBUG
		isSwimming = 1

func _on_Testbody_body_exited(body):
	if body != self :
		dashTestBodiesCounter -= 1
		print("Exited") #DEBUG
		isSwimming = 0
		isClimbing = 0
		isPushing = 0

func checkPushable():
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
