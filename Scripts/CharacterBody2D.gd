extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var qqundessu = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.

	if qqundessu == true:
		print_debug("testqqundessu")
		velocity.y -= gravity * delta
		get_parent().position.y = get_parent().position.y - 1
	elif qqundessu == false:
		velocity.y += gravity * delta
		move_and_slide()
		
func _on_area_2d_body_entered(body):
	if body.has_method("domage"):
		qqundessu = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	print_debug("testqqunparti")
	qqundessu = false

