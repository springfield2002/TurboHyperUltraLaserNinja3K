extends Area2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var player = null
var speed = 3
func _ready():
	
	look_vec = player.position - global_position
	
func _physics_process(delta):
	
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed 
	position += move




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_shuriken_body_entered(body):
	if body.is_in_group("player"):
		body.hit(1);
	pass # Replace with function body.
