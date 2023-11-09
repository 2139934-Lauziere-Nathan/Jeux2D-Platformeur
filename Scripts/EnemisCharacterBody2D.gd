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
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D



const SPEED = 60
const JUMP_VELOCITY = -40.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1


func _physics_process(delta):
	#selectIdleOrWalk()
	#if state == WALK && $Timer.is_stopped():
		#selectDirection()
	selecIdleOrWalkplusDirection()
	
	etas()
	
	
	velocity.y += gravity * delta
	move_and_slide()

func selecIdleOrWalkplusDirection():
	var randomNumber = ceil(randf_range(0, 2))
	var randomNumberdir = ceil(randf_range(0, 2))
	if state != ATTACK && $Timer.is_stopped():

		

		if randomNumber == 1:
			state = IDLE

		elif randomNumber == 2:
			

			if randomNumberdir == 1 && $Timer.is_stopped():
				direction = 1

			elif randomNumberdir == 2 && $Timer.is_stopped():
				direction = 2

			state = WALK
		$Timer.start()
func etas():
	match state:
		IDLE:

			anim.play("IDLE")
			velocity.x = 0
			if direction == 1:
				if anim.scale.x != 1:
					anim.scale.x = 1
					colisionArea.position.x *= 1
					colisionBody.position.x *= 1
					ray2D2.position.x *= 1
			elif direction == 2:
				if anim.scale.x != -1:
					anim.scale.x = -1 
					colisionArea.position.x *= -1
					colisionBody.position.x *= -1
					ray2D.position.x *=-1
					ray2D2.position.x *=-1
				
			
		WALK:

			anim.play("RUN")
			detect_fall()
			detectmur()
			
			if direction == 1:
				velocity.x = SPEED
				detect_fall()
				if anim.scale.x != 1:
					anim.scale.x = 1
					colisionArea.position.x *= 1
					colisionBody.position.x *= 1
					
					ray2D2.position.x *= 1
			elif direction == 2:
				velocity.x = -SPEED
				if anim.scale.x != -1:
					anim.scale.x = -1  # Flip animation if moving left
					colisionArea.position.x *= -1
					colisionBody.position.x *= -1
					ray2D.position.x *=-1
					
					ray2D2.position.x *=-1
				detectmur()
				detect_fall()
			
		ATTACK:
			anim.play("Attack")
		JUMP:
			anim.play("JUMP")
			velocity.y = (1 * JUMP_VELOCITY )
			if direction == 1:
				velocity.x = SPEED
			if  direction == 2:
				velocity.x = -SPEED
			
			
func detect_fall():
	
	if not ray2D.is_colliding():
		print_debug("testarrettrous")
		$Timer.start()
		$Timer.wait_time = 1
		state = JUMP
		
		#if direction == 1:
		#	direction = 2
		#elif direction == 2:
		#	direction = 1
func detectmur():
	if ray2D2.is_colliding():
		state = IDLE
		velocity.x = 0
		print_debug("test detection de mur")
		$Timer.start()
		if direction == 1:
			direction = 2
		elif direction == 2:
			direction = 1
		move_and_slide()

func _on_area_2d_body_entered(body):
	

	if body.has_method("domage"):
		state = ATTACK
		body.domage()
	else:
		state = IDLE
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	if state == ATTACK || WALK:
		state = IDLE
	pass # Replace with function body.
