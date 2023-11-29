extends Node2D
var barre = true
signal signalecle(barre)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("signalecle", barre)
	pass


func _on_area_2d_2_body_entered(body):
	barre = false
	emit_signal("signalecle", barre)
	queue_free()
	pass # Replace with function body.
