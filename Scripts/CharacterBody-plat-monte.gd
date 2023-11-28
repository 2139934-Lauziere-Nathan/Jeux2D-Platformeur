extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 101


func _physics_process(delta):
	if gravity <= 100:
		if not is_on_floor():
			print_debug("testplat")
			velocity.y += gravity * delta
			move_and_slide()



	
