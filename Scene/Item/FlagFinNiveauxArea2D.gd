extends Area2D
var niveaux
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	niveaux = Global.niveau
	pass


func _on_body_entered(body):
	print_debug("%s"%(niveaux+1))
	Global.niveau = Global.niveau+1
	#get_tree().change_scene_to_file("res://Scene/Level/niveaux_%s.tscn"%(niveaux+1))
	pass # Replace with function body.
