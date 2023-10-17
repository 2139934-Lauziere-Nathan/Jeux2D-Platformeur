extends CharacterBody2D

enum {
	WALK,
	IDLE,
	ATTACK
}

var state = WALK
@onready var anim = $AnimatedSprite2D
@onready var ray2D = $RayCast2D

var is_moving_left = false
var is_moving_right = false
var is_idle = true

const SPEED = 50
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var timer_idle = 500
var timer_run = 50
var direction = null
var randomNumber = ceil(randf_range(0, 2))

func _physics_process(delta):
	if timer_idle == 0:
		state = WALK
	else:
		state = IDLE
		timer_idle = timer_idle - 1
	
	if state == WALK:
		timer_run = timer_run - 1
		print_debug(randomNumber)
		if randomNumber == 2:
			direction = 1
		else:
			direction = 0
		if timer_run == 0:
			timer_idle = 150
			timer_run = 50
			randomNumber = ceil(randf_range(0, 2))
	
	if not is_on_floor():
		velocity.y += gravity * delta

	match state:
		IDLE:
			anim.play("IDLE")
			velocity.x = 0
			if direction == 1:
				anim.scale.x = 1
			else:
				anim.scale.x = -1  # Flip animation if moving left
			
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
	
	move_and_slide()
var cooldown = 0
func attack():
	if cooldown == 0:
		cooldown = 50
		Global.life= Global.life-1
	cooldown = cooldown-1
	
func detect_fall():
	if not ray2D.is_colliding() and is_on_floor():
		state = IDLE
		velocity.x = 0


func _on_area_2d_body_entered(body):
	state = ATTACK
	attack()
	pass # Replace with function body.
