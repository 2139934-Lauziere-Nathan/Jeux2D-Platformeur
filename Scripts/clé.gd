extends Area2D



signal key_taken


func _on_body_entered(body):
	emit_signal("key_taken")
	queue_free()
	pass # Replace with function body.
