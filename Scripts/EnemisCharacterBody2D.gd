extends CharacterBody2D

enum {
	WALK,
	IDLE,
	ATTACK,
	JUMP
}

var state = WALK
@onready var anim = $AnimatedSprite2D
@onready var ray2D = $RayCast2D
@onready var ray2D2 = $RayCast2D2
@onready var ray2D3 = $RayCast2D3
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D



const SPEED = 60
const JUMP_VELOCITY = -40.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = null

func  _ready():
	direction = 1
func _physics_process(delta):
	#selectIdleOrWalk()
	#if state == WALK && $Timer.is_stopped():
		#selectDirection()
	detctTomberdansUnTrous()
	select_rand_etas()
	
	etas2()
	
	
	velocity.y += gravity * delta
	move_and_slide()
func selectdir():

	if randi() % 2 == 0:
		direction = 1
	
	elif randi() % 2 == 1:
		direction = -1
	print_debug(direction)
	updateCharacterDirection()
	
func select_rand_etas():
	if $Timer.is_stopped():
		var rand = randi() % 2 == 0
		if rand == true:
			state = IDLE

		elif rand == false:
			selectdir()
			state = WALK

		$Timer.start()

		
func etas2():
	match state:
		IDLE:
			handleIdleState()

		WALK:
			handleWalkState()

		ATTACK:
			anim.play("Attack")

		JUMP:
			handleJumpState()

func handleIdleState():
	updateCharacterDirection()
	anim.play("IDLE")
	velocity.x = 0
	

func handleWalkState():
	updateCharacterDirection()
	anim.play("RUN")
	detect_fall()
	detectmur()
	detectMurEtPasTrous()
	print_debug(direction)
	if direction == 1:
		velocity.x = SPEED
	elif  direction == -1:
		velocity.x = -SPEED
	

	

func handleJumpState():
	if $Timer.is_stopped():
		velocity.y = JUMP_VELOCITY
		anim.play("JUMP")
		detectMurEtPasTrous()
		if direction == 1:
			velocity.x = SPEED
		elif direction == -1:
			velocity.x = -SPEED
		$Timer.start()

func updateCharacterDirection():
	anim.scale.x = direction
	colisionArea.scale.x *= direction
	colisionBody.scale.x *= direction
	ray2D.scale.x *= direction
	ray2D2.scale.x *= direction
	ray2D3.scale.x *= direction

func setCharacterDirection(scaleFactor):
	anim.scale.x = scaleFactor
	colisionArea.scale.x *= scaleFactor
	colisionBody.scale.x *= scaleFactor
	ray2D.scale.x *= scaleFactor
	ray2D2.scale.x *= scaleFactor
	ray2D3.scale.x *= scaleFactor
			
func detect_fall():
	
	if not ray2D.is_colliding():

		
		
		state = JUMP
		
		#if direction == 1:
		#	direction = 2
		#elif direction == 2:
		#	direction = 1
func detectmur():
	if ray2D2.is_colliding():
		state = IDLE
		velocity.x = 0

		$Timer.start()
		if direction == 1:
			direction = -1
		elif direction == -1:
			direction = 1
		updateCharacterDirection()
		move_and_slide()
		return true
	return false
func detectMurEtPasTrous():
	if ray2D2.is_colliding():
		if not ray2D3.is_colliding():
			state = JUMP
			return true
	return false
func detctTomberdansUnTrous():
	if ray2D.is_colliding():
		if ray2D2.is_colliding():
			state = JUMP
			return true
	return false
func _on_area_2d_body_entered(body):
	

	if body.has_method("domage"):
		state = ATTACK
		body.domage()

	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	if state == ATTACK:
		state = IDLE
	pass # Replace with function body.
	
	

