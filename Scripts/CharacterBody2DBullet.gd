extends CharacterBody2D


const speed = 300
var direction = Vector2()
var passBody = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	position -= transform.y * speed * delta
	rotation - 90
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("domage") && passBody == true:
		body.domage()
		queue_free()
	if passBody == false:
		passBody = true
	pass # Replace with function body.
