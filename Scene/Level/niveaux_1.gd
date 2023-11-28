extends Node2D

var flag_ = false
signal signalflag(flag)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func _on_flag_fin_niveau_flagsignal(flag):
	flag_ = flag
	emit_signal("signalflag", flag)
	pass # Replace with function body.



