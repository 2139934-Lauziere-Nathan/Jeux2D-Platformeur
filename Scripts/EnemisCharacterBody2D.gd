extends CharacterBody2D

enum {
	WALK,
	IDLE,
	ATTACK
}

var state = WALK
@onready var anim = $AnimatedSprite2D
@onready var ray2D = $RayCast2D
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D

var is_moving_left = false
var is_moving_right = false
var is_idle = true

const SPEED = 50
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = null
var randomNumber = ceil(randf_range(0, 2))
var randomNumberdir = ceil(randf_range(0, 2))

func _physics_process(delta):
	
	
	if state != ATTACK && $Timer.is_stopped():
		print_debug(randomNumber)
		$Timer.start()
		if randomNumber == 1:
			state = IDLE
		elif randomNumber == 0:
			state = WALK
			if randomNumberdir == 1:
				randomNumberdir == 1
	etas()
	
	
	move_and_slide()
var cooldown = 0

func etas():
	match state:
		IDLE:
			anim.play("IDLE")
			velocity.x = 0
			if direction == 1:
				anim.scale.x = 1
				colisionArea.scale.x = 1
				colisionBody.scale.x = 1
			else:
				anim.scale.x = -1  # Flip animation if moving left
				colisionArea.scale.x = -1
				colisionBody.scale.x = -1
			
		WALK:
			anim.play("RUN")
			velocity.x = (SPEED if direction == 1 else -SPEED)
			detect_fall()
			if direction == 1:
				anim.scale.x = 1
			else:
				anim.scale.x = -1  # Flip animation if moving left
			
		ATTACK:
			anim.play("Attack")
func detect_fall():
	if not ray2D.is_colliding() and is_on_floor():
		state = IDLE
		velocity.x = 0


func _on_area_2d_body_entered(body):
	
	print_debug("bodyentered")
	if body.has_method("domage"):
		state = ATTACK
		body.domage()
	else:
		state = IDLE
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	state = IDLE
	pass # Replace with function body.
