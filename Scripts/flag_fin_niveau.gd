extends Node2D

var flag = false
@onready var  anim = $Area2D/AnimatedSprite2D
signal flagsignal(flag)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	anim.play("idle")
	if flag == true:
		emit_signal("flagsignal", flag)
		flag = false
	pass


func _on_area_2d_body_entered(body):
	flag = true
	pass # Replace with function body.
