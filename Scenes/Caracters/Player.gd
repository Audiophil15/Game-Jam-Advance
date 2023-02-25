extends KinematicBody2D

var defaultSpeed
var isDashing
var dashSpeed
var velocity
var collided
var dashTestBodiesCounter
var dashStartPos

# Called when the node enters the scene tree for the first time.
func _ready():
	defaultSpeed = 50
	dashSpeed = 5*defaultSpeed
	velocity = Vector2()
	dashTestBodiesCounter = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.z_index = int(self.position.y)
	
	if not isDashing :
		velocity = Vector2()
		if Input.is_action_pressed("ui_right") :
			velocity.x += 1
		if Input.is_action_pressed("ui_left") :
			velocity.x -= 1
		if Input.is_action_pressed("ui_up") :
			velocity.y -= 1
		if Input.is_action_pressed("ui_down") :
			velocity.y += 1
	if Input.is_action_just_pressed("dash") :
		dash()
		disableDashMask()
	if velocity.length() > 0 :
		velocity = velocity.normalized() * (defaultSpeed if not isDashing else dashSpeed)
		if isDashing :
			$Sprite.play("Dash")
		# Swim / Push
		else :
			$Sprite.play("Down")
	else :
		$Sprite.play("default")

	collided = move_and_slide(velocity)

func dash() :
	isDashing = true
	dashStartPos = self.position
	yield(get_tree().create_timer(0.3), "timeout")
	if dashTestBodiesCounter :
		# Timeout pour l'anim de noyade/chute
		self.position = dashStartPos
	self.collision_mask = 15
	isDashing = false

func disableDashMask() :
	self.collision_mask = 13

func _on_Testbody_body_entered(body):
	if body != self :
		dashTestBodiesCounter += 1
		print("Add 1 ", dashTestBodiesCounter)

func _on_Testbody_body_exited(body):
	if body != self :
		dashTestBodiesCounter -= 1
		print("Del 1 ", dashTestBodiesCounter)
