extends Node2D
@onready var lable_vie = $Control/CanvasLayer/VBoxContainer/Vie
@onready var lable_token = $Control/CanvasLayer/VBoxContainer/Token

var _vie
var tok

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	lable_vie.text = str("vie = ",_vie)
	lable_token.text = str("token = ",tok)
	#lable_vie.text = str("life = ",Global.life)
	pass


func _on_character_body_2d_signal_vie(vie):
	
	_vie = vie
	pass # Replace with function body.


func _on_character_body_2d_signal_token(token):
	
	tok = token
	pass # Replace with function body.
