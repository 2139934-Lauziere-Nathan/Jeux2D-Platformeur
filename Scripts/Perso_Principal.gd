extends CharacterBody2D

var speed = 300.0
var jump_speed = 400.0

var vie 
var token 
var is_jumping = false
var double_saut = 0
var dash = 1
var can_Dash = false
var climbing = false
signal signalVie(vie)
signal signalToken(token)
@onready var _animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 

func _ready():
	vie =+ 3
	token =+ 0

func _physics_process(delta):
	emit_signal("signalVie", vie)
	emit_signal("signalToken", token)
	
#<----------ANIMATIONS-------------------------------------->
	if is_on_floor():
		if Input.is_action_pressed("mouvement-droit"):
			_animated_sprite.flip_h = false
			_animated_sprite.position = Vector2(6, -2)
			_animated_sprite.play("run")
		
	if is_on_floor():
		if Input.is_action_pressed("mouvement-gauche"):
			_animated_sprite.flip_h = true
			_animated_sprite.position = Vector2(-16, -2)
			_animated_sprite.play("run")
			
	if climbing:
		_animated_sprite.play("idle")
		
	if velocity.x == 0 and is_on_floor() and !Input.is_action_pressed("saut"):
		_animated_sprite.play("idle")
	
	
#<-------------------------MOUVEMENTS-------------------------------------->
	if is_on_floor():
		double_saut = 1
		dash = 1
	
	# Get the input direction.
	var direction = Input.get_axis("mouvement-gauche", "mouvement-droit")
	velocity.x = direction * speed
	if not climbing:
		velocity.y += gravity * delta
	elif climbing:
		velocity.y = 0
		if Input.is_action_pressed("saut"):
			velocity.y = -speed
		elif Input.is_action_pressed("tomber"):
			velocity.y = speed

#<-------------------------SAUTS-------------------------------------->
	if Input.is_action_just_pressed("saut") and is_on_floor():
			velocity.y = (0.8 -jump_speed )
			double_saut = 1
			_animated_sprite.play("saut")
			
			
	if Input.is_action_just_pressed("saut") and double_saut == 1  and !is_on_floor():
			velocity.y = (1 * -jump_speed )
			double_saut = 0
			_animated_sprite.play("double_saut")
			
	
	if Input.is_action_just_pressed("Dash") and !is_on_floor() and dash == 1 and can_Dash == true:
		velocity.x = (direction * speed) * 15
		dash = 0
	
	mort()
	move_and_slide()


#<-------------------------FUNCTION-------------------------------------->
func unlock_dash():
	can_Dash = true

func plustoken():

	token = token+1
func plusvie():
	vie= vie+1
func mort():
	if vie <= 0:
		get_tree().change_scene_to_file("res://Scene/Menus/game_over_screen.tscn")
func domage():
	velocity.x = -(1 * -speed )
	velocity.y = (1 * -jump_speed )
	vie = vie-1
	mort()
func is_ciblePrincipal():
	return $CollisionShape2D.position
	
