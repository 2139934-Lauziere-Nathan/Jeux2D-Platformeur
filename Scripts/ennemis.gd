extends Node2D
@onready var anim = $AnimatedSprite2D
@onready var ray2D = $RayCast2D
@onready var ray2D2 = $RayCast2D2
@onready var ray2D3 = $RayCast2D3
@onready var ray2D4 = $RayCast2D4
@onready var ray2D5 = $RayCast2D5
@onready var ray2D6 = $RayCast2D6
@onready var rayAttack1 = $rayAttack1
@onready var rayAttack2 = $rayAttack2
@onready var rayAttack3 = $rayAttack3
@onready var Vue = $Vision
@onready var Sol = $DetectSol
@onready var Step = $DetectStep
@onready var colisionBody = $CollisionShape2D
@onready var colisionArea = $Area2D/CollisionShape2D
@onready var colisionArea2 = $Area2D/CollisionShape2D2
var direction = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateCharacterDirection():
	anim.scale.x *= direction
	ray2D.scale.x *= direction
	ray2D2.scale.x *= direction
	ray2D3.scale.x *= direction
	ray2D4.scale.x *= direction
	ray2D5.scale.x *= direction
	ray2D6.scale.x *= direction
	Sol.scale.x *= direction
	Vue.scale.x *= direction
	Step.scale *= direction
	rayAttack1.scale *= direction
	rayAttack2.scale *= direction
	rayAttack3.scale *= direction
