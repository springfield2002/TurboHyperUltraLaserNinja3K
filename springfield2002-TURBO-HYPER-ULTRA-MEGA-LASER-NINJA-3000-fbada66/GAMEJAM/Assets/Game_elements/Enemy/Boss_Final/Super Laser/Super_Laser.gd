extends Area2D

const speed = 250
var velocity = Vector2()
var direction = 1

func set_shoot_direction(dir):
	if direction == 1:
		direction = dir
		$AnimatedSprite.flip_h = false
	if direction == -1:
		direction = dir
		$AnimatedSprite.flip_h = true
		
func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	pass # Replace with function body.


func _on_Super_Laser_body_entered(body):
	if body.is_in_group("player"):
		body.hit(2)
		queue_free()
	pass # Replace with function body.
