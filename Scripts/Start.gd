extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	
	Global.life = 3
	Global.etas = 0
	get_tree().change_scene_to_file("res://Scene/Level/main.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass