extends Node2D
@onready var body = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if $Timer.is_stopped():
		
		body.gravity = -980
	pass


func _on_area_2d_body_entered(body):

	if body.has_method("domage"):

	

		
		$Timer.one_shot = true


	pass # Replace with function body.
