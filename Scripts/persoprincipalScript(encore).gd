extends CharacterBody2D

var speed = 300.0
var jump_speed = 400.0
var life = Global.life
var is_jumping = false
var double_saut = 0
var dash = 1

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _collision = $CollisionShape2D

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
	

	
func _physics_process(delta):
		# Get the input direction.
	var direction = Input.get_axis("mouvement-gauche", "mouvement-droit")
	velocity.x = direction * speed
	velocity.y += gravity * delta
	
#<----------ANIMATIONS-------------------------------------->
	if is_on_floor():
		if Input.is_action_pressed("mouvement-droit"):
			_animated_sprite.flip_h = false
			_animated_sprite.position = Vector2(6, -2)
			_animated_sprite.play("RUN")
		
	if is_on_floor():
		if Input.is_action_pressed("mouvement-gauche"):
			_animated_sprite.flip_h = true
			_animated_sprite.position = Vector2(-16, -2)
			_animated_sprite.play("RUN")
		
	if velocity.x == 0 and is_on_floor() and !Input.is_action_pressed("saut"):
		_animated_sprite.play("IDLE")
	
	
#<-------------------------MOUVEMENTS-------------------------------------->
	if Input.is_action_pressed("mouvement-droit"):
		_animated_sprite.flip_h = false
		_animated_sprite.position = Vector2(6, -2)
	if Input.is_action_pressed("mouvement-gauche"):
		_animated_sprite.flip_h = true
		_animated_sprite.position = Vector2(-16, -2)
	
	
	
	
	if Input.is_action_just_pressed("saut") and is_on_floor():
			velocity.y = (0.8 -jump_speed )
			double_saut = 1
			_animated_sprite.play("JUMP")
			
			
	if Input.is_action_just_pressed("saut") and double_saut == 1  and !is_on_floor():
			velocity.y = (1 * -jump_speed )
			double_saut = 0
			_animated_sprite.play("JUMP")
			
			
	if Input.is_action_just_pressed("Dash") and !is_on_floor() and dash == 1:
		velocity.x = (direction * speed) * 15
		dash = 0
	
	
	if is_on_floor():
		double_saut = 1
		dash = 1


	move_and_slide()

