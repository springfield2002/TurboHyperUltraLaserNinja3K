extends Area2D

const speed = 250
var velocity = Vector2()
var direction = 1

func set_shoot_direction(dir):
	direction = dir
		
func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	pass # Replace with function body.
