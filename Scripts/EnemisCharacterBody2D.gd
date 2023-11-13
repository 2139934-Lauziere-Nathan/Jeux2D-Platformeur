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
@onready var ray2D4 = $RayCast2D4
@onready var TimerAgression = $TimerAgression
@onready var Vue = $Vision
@onready var Sol = $DetectSol
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D



const SPEED = 60
const JUMP_VELOCITY = -200.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = null

func  _ready():
	direction = 1
func _physics_process(delta):
	#selectIdleOrWalk()
	#if state == WALK && $Timer.is_stopped():
		#selectDirection()
	if $Timer.is_stopped():
		select_rand_etas()
	TriggerAggression()
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
	SauteAvantDeTomber()
	dontKissTheWall()
	anim.play("RUN")
	detctTomberdansUnTrous()
	print_debug(direction)
	if direction == 1:
		velocity.x = SPEED
	elif  direction == -1:
		velocity.x = -SPEED
	

	

func handleJumpState():
	if detectground() == true:
		velocity.y = JUMP_VELOCITY
	

func updateCharacterDirection():
	anim.scale.x = direction
	colisionArea.scale.x *= direction
	colisionBody.scale.x *= direction
	ray2D.scale.x *= direction
	ray2D2.scale.x *= direction
	ray2D3.scale.x *= direction


			
func detect_fall():
	
	if not ray2D.is_colliding():

		
		
		state = JUMP
		
		#if direction == 1:
		#	direction = 2
		#elif direction == 2:
		#	direction = 1
func detectmurAvant():
	if ray2D2.is_colliding():
		
		return true
	return false
func detectground():
	if not Sol.is_colliding():
		return true
	return false
func dontKissTheWall():
	if detectmurAvant() == true:
		if direction != 1:
			direction = 1
		elif direction == 1:
			direction = -1
	updateCharacterDirection()
func detctTomberdansUnTrous():
	if detectmurAvant() == true:
		if ray2D4.is_colliding():
			if not ray2D3.is_colliding():
				print_debug("detctTomberdansUnTrous()")
				$Timer.stop()
				state = JUMP
				$Timer.start()
func SauteAvantDeTomber():
	if Sol.is_colliding():
		if not ray2D.is_colliding():
			$Timer.stop()
			state = JUMP
			$Timer.start()
func TriggerAggression():
	if Vue.collide_with_bodies == true:
		var collider = Vue.get_collider()
		if collider and collider is CharacterBody2D:
			state = WALK

	
func _on_area_2d_body_entered(body):
	

	if body.has_method("domage"):
		state = ATTACK
		body.domage()

	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	if state == ATTACK:
		state = IDLE
	pass # Replace with function body.
	
	

