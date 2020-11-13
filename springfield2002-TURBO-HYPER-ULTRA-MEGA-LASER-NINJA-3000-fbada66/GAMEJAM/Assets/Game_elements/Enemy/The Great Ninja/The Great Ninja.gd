extends KinematicBody2D

var move = Vector2.UP
var gravity = 20
var speed = 20
var acell = 30
var player = null
var motion = Vector2()
var direction = false
func _physics_process(delta):
	move = Vector2.UP
	if player != null:
		if direction == false:
			motion.x += acell
		if direction == true:
			motion.x -= acell	
	else:
		move = Vector2.UP
	
	move = move.normalized()
	motion = move_and_slide(motion,move)
	motion.y += gravity
	motion.x = clamp(motion.x, -speed, speed)


func _on_EyeL_body_entered(body):
	if body.name == "Node2D3":
		direction = true
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
		player = body


func _on_EyeL_body_exited(body):
	player = null


func _on_EyeD_body_entered(body):
	if body.name == "Node2D3":
		direction = false
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
		player = body


func _on_EyeD_body_exited(body):
	player = null


func _on_Area2DLeft_body_entered(body):
	if body.name == "Node2D3":
		motion.x = clamp(motion.x, 0, 0)
		$AnimatedSprite.play("Attack")
		yield(get_tree().create_timer(1.0),"timeout")
func _on_Area2DLeft_body_exited(body):
	$AnimatedSprite.play("Attack")



func _on_Area2DRight_body_entered(body):
	if body.name == "Node2D3":
		motion.x = clamp(motion.x, 0, 0)
		$AnimatedSprite.play("Attack")
		yield(get_tree().create_timer(1.0),"timeout")
		$AnimatedSprite.flip_h = false



func _on_Area2DRight_body_exited(body):
	$AnimatedSprite.play("Idle")

