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
@onready var ray2D = $RayCast2D
@onready var ray2D2 = $RayCast2D2
@onready var ray2D3 = $RayCast2D3
@onready var ray2D4 = $RayCast2D4
@onready var ray2D5 = $RayCast2D5
@onready var ray2D6 = $RayCast2D6
@onready var rayAttack1 = $rayAttack1
@onready var rayAttack2 = $rayAttack2
@onready var rayAttack3 = $rayAttack3
@onready var Vue = $Vision
@onready var Sol = $DetectSol
@onready var Step = $DetectStep
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D
@onready var colisionArea2 = $Area2D/CollisionShape2D2


var jump_timer = 0.0
var max_jump_time = 1.0  # Adjust this value to control the maximum air time for the jump

const SPEED = 120
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = null

func  _ready():
	direction = 1
func _physics_process(delta):

	if $Timer.is_stopped():
		print_debug("un etas random a ete choisis")
		select_rand_etas()
		print_debug(state);
		$Timer.start()
	print_debug(state)
	TriggerAggression()
	marchePasPourRien()
	etas2()

	
	velocity.y += gravity * delta
	move_and_slide()
func selectdir():

	if randi() % 2 == 0:
		direction = 1
	
	elif randi() % 2 == 1:
		direction = -1

	updateCharacterDirection()
	
func select_rand_etas():
	if $Timer.is_stopped():
		var rand = randi() % 2 == 0
		print_debug("selection d'etas random")
		if rand == true:
			state = IDLE

		elif rand == false:
			selectdir()
			state = WALK

		

		
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
	TimerIdle = $TimerIdle
	updateCharacterDirection()
	anim.play("IDLE")
	velocity.x = 0
	detectPersonneEnArriere()
	var rand = randi() % 5 + 1
	TimerIdle.wait_time = rand

	if TimerIdle.is_stopped():
		changerDir()
		
		$TimerIdle.start()
	updateCharacterDirection()
	

func handleWalkState():
	updateCharacterDirection()

	detctTomberdansUnTrous()
	PasserPetitObstacle()
	detectSlope()
	detectPersonneEnArriere()
	passerGrandObstacle()
	passerGrosTrous()
	SauteAvantDeTomber()
	dontKissTheWall()
	TriggerIdle()
	updateCharacterDirection()
	anim.play("RUN")
	if direction == 1:
		velocity.x = SPEED
	elif  direction == -1:
		velocity.x = -SPEED
	

	

func handleJumpState():
	if detectground() == true:

		if $TimerSaut.is_stopped():
			velocity.y = JUMP_VELOCITY
			
			$TimerSaut.start()
			if direction == 1:
				velocity.x = SPEED
			elif  direction == -1:
				velocity.x = -SPEED
	

func updateCharacterDirection():
	anim.scale.x = direction
	ray2D.scale.x *= direction
	ray2D2.scale.x *= direction
	ray2D3.scale.x *= direction
	ray2D4.scale.x *= direction
	ray2D5.scale.x *= direction
	ray2D6.scale.x *= direction
	Sol.scale.x *= direction
	Vue.scale.x *= direction
	Step.scale *= direction
	rayAttack1.scale *= direction
	rayAttack2.scale *= direction
	rayAttack3.scale *= direction


	
func detectmurAvant():
	if ray2D2.is_colliding():
		if checkColHumain(ray2D2.get_collider()) == false:
			return true
	return false
func detectground():
	if not Sol.is_colliding():
		return true
	return false
func dontKissTheWall():
	
	if detectmurAvant() == true:
		print_debug("dontKissTheWall")
		changerDir()
func detectSlope():
	if not ray2D6.is_colliding():
		if Step.is_colliding():
			if detectmurAvant() == true:
				state = JUMP
func detectPersonneEnArriere():
	if ray2D4.is_colliding():
		if checkColHumain(ray2D4.get_collider())== true:
			print_debug("coliderarrier")
			changerDir()
func detctTomberdansUnTrous():
	if detectmurAvant() == true:
		if ray2D4.is_colliding():
			if not ray2D3.is_colliding():
				print_debug("detctTomberdansUnTrous")
				$TimerSaut.stop()
				
				state = JUMP
				
func SauteAvantDeTomber():
	if Sol.is_colliding():
		if not ray2D.is_colliding():
			print_debug("SauteAvantDeTomber")
			$TimerSaut.stop()
			state = JUMP

func PasserPetitObstacle():
	if Step.is_colliding():
		if detectmurAvant() == false:
			print_debug("PasserPetitObstacle")
			$TimerSaut.stop()
			$Timer.start()
			state = JUMP

func passerGrosTrous():
	if ray2D5.is_colliding() && Sol.is_colliding():
		if not ray2D.is_colliding():
			print_debug("passerGrosTrous")
			$TimerSaut.stop()
			state = JUMP

func passerGrandObstacle():
	if Step.is_colliding():
		if Sol.is_colliding():
			if not ray2D3.is_colliding():
				print_debug("passerGrandObstacle")
				$TimerSaut.stop()
				$Timer.start()
				state = JUMP
func TriggerIdle():
	if velocity.x == 0:
		if state != ATTACK:
			if state == WALK:
				state = IDLE
func marchePasPourRien():
	if TriggerAggression() != true:
		if $Timermarche.is_stopped():
			velocity.x = 0
			TriggerIdle()
func TriggerAggression():
	if (rayAttack1.collide_with_bodies || rayAttack2.collide_with_bodies || rayAttack3.collide_with_bodies || Vue.collide_with_bodies) == true:
		var collider = rayAttack1.get_collider()
		var collider2 = rayAttack2.get_collider()
		var collider3 = rayAttack3.get_collider()
		var  collider4 = Vue.get_collider()
		if checkColHumain(collider) == true ||checkColHumain(collider2) == true || checkColHumain(collider3) == true || checkColHumain(collider4) == true:
			print_debug("coliderpassHumain")
			state = WALK
			return true
func checkColHumain(collider):
	if collider and collider is CharacterBody2D:
		return true
	return false
func chekColMur(collider):
	if collider and collider.is_in_group("test"):
		return true
	return false
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
	
	

