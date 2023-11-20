extends Node2D
@onready var anim = $AnimatedSprite2D
@onready var raycast = $RayCast2D
@onready var marker = $AnimatedSprite2D/Marker2D
const  bulletPaht = preload('res://Scene/Item/missile.tscn')
var actif = false
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if raycast.is_colliding():
		
		if $Timer4Timer.is_stopped():
			actif = true

			anim.play("new_animation")
		
		if $Timer.is_stopped() && actif == true:
			$Timer.start()

			var b = bulletPaht.instantiate()


			get_tree().root.add_child(b)
			b.transform = marker.global_transform
	else:
		$Timer4Timer.start()
		actif = false
		anim.play("default")
	pass
