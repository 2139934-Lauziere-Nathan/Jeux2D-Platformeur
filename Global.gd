extends Node
var max_life = 3
var life = 3
var etas = 0
var token = 0
var niveau = 1
#zero menu , 1  - niveau 1 
# Called when the node enters the scene tree for the first time.
func _ready():
	_start()
	pass
	# Load the level scene
func _start():
	var newlv = load("res://Scene/Level/niveaux_1.tscn")
	var reslv = newlv.instantiate()
	add_child(reslv)
	
	pass # Replace with function body.
func _moinUneVie():
	
	life= life-1
func _plusUneVie():
	
	life= life+1
	
func _plusUnToken():
	token= token+1
func death():
	if etas == 0 && life <= 0:
		
		etas = 1
		get_tree().change_scene_to_file("res://Scene/Menus/game_over_screen.tscn")
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if life <= 0:
		death()
	if etas != 1:
		death()
	if niveau == 2:
		print_debug("testchangelv",niveau)
		
		
		
	


func _on_flag_fin_niveau_2_flagsignal(flag):
	
	niveau +1
	var lv = get_child(3)
	
	remove_child(lv)



	var newlv = load("res://Scene/Level/Niveau_2.tscn")
	var reslv = newlv.instantiate()
	add_child(reslv)
	
	pass # Replace with function body.
