extends Node2D

@onready var body = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_stop_point_assenseur_stop():
	body.velocity.y = 0
	pass # Replace with function body.


func _on_stop_point_assenseur_2_stop():
	body.velocity.y = 0
	pass # Replace with function body.
