extends Node2D
var barre2 = true
signal signalecle2(barre2)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("signalecle2", barre2)
	pass


func _on_area_2d_2_body_entered(body):
	barre2 = false
	emit_signal("signalecle2", barre2)
	queue_free()
	pass # Replace with function body.
