extends Area2D
export var speed = 800
var movement = Vector2(0,0)
var direction = 1
signal hit

func _ready():
	pass

func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.scale.x = -1

func _physics_process(delta):
	movement.x = speed * delta * direction
	translate(movement)
	

	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
