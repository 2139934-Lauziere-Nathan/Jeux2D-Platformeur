extends CharacterBody2D

enum {
	WALK,
	IDLE,
	ATTACK,
	JUMP
}
var TimerIdle : Timer
var state = IDLE
@onready var anim = $AnimatedSprite2D
@onready var excl = $SpriteExclam
@onready var ray2D = $RayCast2D
@onready var ray2D2 = $RayCast2D2

@onready var ray2D4 = $RayCast2D4
@onready var ray2D5 = $RayCast2D5
@onready var ray2D6 = $RayCast2D6
@onready var ray2D7 = $RayCast2D7
@onready var rayAttack1 = $rayAttack1
@onready var rayAttack2 = $rayAttack2
@onready var rayAttack3 = $rayAttack3
@onready var Vue = $Vision
@onready var Sol = $DetectSol
@onready var Step = $DetectStep
@onready var Step2 = $DetectStep2
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D
@onready var colisionArea2 = $Area2D/CollisionShape2D2

var excpop = 0
var jump_timer = 0.0
var max_jump_time = 1.0  # Adjust this value to control the maximum air time for the jump

const SPEED = 120
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

func  _ready():
	direction =-1
	excl.hide()
	
func _physics_process(delta):
	TriggerIdle()
	etas2()
	updateCharacterDirection()
	if excpop == 0:
		excl.hide()

	velocity.y += gravity * delta
	move_and_slide()

func etas2():
	match state:
		IDLE:
			TriggerAggression()
			handleIdleState()
		WALK:
			SauteAvantDeTomber()
			detectSlope()
			handleWalkState()
		ATTACK:
			anim.play("Attack")
		JUMP:
			handleJumpState()
			
func handleIdleState():
	TimerIdle = $TimerIdle
	detectPersonneEnArriere()
	anim.play("IDLE")
	velocity.x = 0
	var rand = randi() % 5 + 1
	TimerIdle.wait_time = rand
	if TimerIdle.is_stopped():
		if $TimerIdle.is_stopped():
			if TriggerAggression() != true:

				changerDir()
				$TimerIdle.start()
				selectMarcheAleatoire()

func handleWalkState():
	anim.play("RUN")
	if direction == 1:
		velocity.x = SPEED
	elif  direction == -1:
		velocity.x = -SPEED
	$Timermarche.start()

func handleJumpState():
		if $TimerSaut.is_stopped():
			velocity.y = JUMP_VELOCITY
			$TimerSaut.start()
			if direction == 1:
				velocity.x = SPEED
			elif  direction == -1:
				velocity.x = -SPEED
		else:
			state = IDLE
	
func updateCharacterDirection():

	anim.scale.x = direction
	ray2D.scale.x = direction
	ray2D2.scale.x = direction

	ray2D4.scale.x = direction
	ray2D5.scale.x = direction
	ray2D6.scale.x = direction
	ray2D7.scale.x = direction
	Sol.scale.x = direction
	Vue.scale.x = direction
	Step.scale.x = direction
	rayAttack1.scale.x = direction
	rayAttack2.scale.x = direction
	rayAttack3.scale.x = direction

func detectSlope():
	if not Step2.is_colliding():
		if Step.is_colliding():
			if Vue.is_colliding():
				state = JUMP
func detectPersonneEnArriere():
	if ray2D4.is_colliding():
		if checkColHumain(ray2D4.get_collider())== true:

			$TimerIdle.start()
			changerDir()

func SauteAvantDeTomber():
	if Sol.is_colliding():
		if ray2D5.is_colliding() or ray2D6.is_colliding() or  ray2D7.is_colliding():
			if not ray2D.is_colliding():

				$TimerSaut.stop()
				state = JUMP

func TriggerIdle():
	if TriggerAggression() != true:
		if state != JUMP:
			if state != ATTACK:
				if is_on_floor():
					

					if $TimerIdle.time_left >= 0:

						excpop = 0
						state = IDLE

func TriggerAggression():
	if (rayAttack1.collide_with_bodies || rayAttack2.collide_with_bodies || rayAttack3.collide_with_bodies || Vue.collide_with_bodies) == true:
		var collider = rayAttack1.get_collider()
		var collider2 = rayAttack2.get_collider()
		var collider3 = rayAttack3.get_collider()
		var  collider4 = Vue.get_collider()
		if checkColHumain(collider) == true ||checkColHumain(collider2) == true || checkColHumain(collider3) == true || checkColHumain(collider4) == true:
			if state != JUMP:

				if $TimerExclamation.is_stopped():
					$TimerExclamation.start()
					excpop = 1
				
				if excpop == 1:
					excl.show()
				state = WALK
		
				return true

		

func checkColHumain(collider):
	if collider and collider is CharacterBody2D:
		return true
	return false
	
func selectMarcheAleatoire():
	var rand = randi() % 2 + 1
	if rand == 1:
		state = WALK
	if rand == 2:
		state = IDLE
	
func changerDir():
		if direction != 1:
			direction = 1
		elif direction == 1:
			direction = -1
func _on_area_2d_body_entered(body):
	$Timer.start()
	if body.has_method("domage"):
		if $TimerAttack.is_stopped():
			state = ATTACK
			body.domage()
			$TimerAttack.start()
func _on_animated_sprite_2d_animation_finished():
	if state == ATTACK:
		state = IDLE
	pass # Replace with function body.
	
	



func _on_detectbodyenbas_body_entered(body):
	if body.has_method("domage"):
		$TimerSaut.stop()
		state = JUMP
		
	pass # Replace with function body.
