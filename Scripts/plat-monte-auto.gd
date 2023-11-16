extends Node2D
@onready var body = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print_debug("timer : ",$Timer.time_left)
	if $Timer.is_stopped():
		print_debug("gravity",body.gravity)
		body.gravity = -980
	pass


func _on_area_2d_body_entered(body):
	print_debug("body_entre")
	if body.has_method("domage"):
		print_debug("body_domage")
	
		print_debug("timer_fini")
		
		$Timer.one_shot = true
		print_debug("timeroneshot",$Timer.one_shot)

	pass # Replace with function body.
