extends Node
var max_life = 3
var life = 3
var etas = 0
var niveau = 0
#zero menu , 1  - niveau 1 
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func _moinUneVie():
	
	life= life-1
func _plusUneVie():
	
	life= life+1
func death():
	if etas == 0 && life <= 0:
		
		etas = 1
		get_tree().change_scene_to_file("res://Scenes/gameOverScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	if etas != 1:
		death()
	
