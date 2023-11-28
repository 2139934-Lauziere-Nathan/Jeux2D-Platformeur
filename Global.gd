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
	niveau +=1
	var lv = get_child(2)
	lv.queue_free()

	if niveau == 2:
		var newlv = load("res://Scene/Level/Niveau_2.tscn")
		var reslv = newlv.instantiate()
		add_child(reslv)
	elif  niveau == 3:
		var newlv3 = load("res://Scene/Level/niveau_3.tscn")
		var reslv3 = newlv3.instantiate()
		add_child(reslv3)
	elif  niveau == 4:
		get_tree().change_scene_to_file("res://Scene/Menus/MenuPrincipal.tscn")
	pass # Replace with function body.
	
func _on_level_completed():
	# Code pour faire disparaître le niveau 1 et charger le niveau 2
	$Niveaux1.queue_free()
	# Charger le niveau 2
	var level2_instance = preload("res://Scene/Level/Niveau_2.tscn").instance()
	add_child(level2_instance)

