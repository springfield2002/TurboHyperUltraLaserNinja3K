extends KinematicBody2D


export  var movement = Vector2(0,0)
export var speed  = 100
export var jump = 300
export var gravity = 10
var second_jump = 3
var dano = 0
export var life = 5
signal hit
var eixo_horizontal



func _physics_process(delta):
	print(movement.y)
	if !is_on_floor():
		movement.y += gravity
		if movement.y > 0:
				$AnimatedSprite.play("fall")
	else:
		second_jump = 3
	if Input.is_action_just_pressed("jump"):	
		if is_on_floor():
			movement.y = -jump
			second_jump  -= 1
		if !is_on_floor() and second_jump > 0:
			movement.y = -jump
			second_jump  -= 1
	
	eixo_horizontal =   Input.get_action_strength("right") - Input.get_action_strength("left")
	movement.x = eixo_horizontal * speed
	
	if is_on_ceiling():
		movement.y = 0
		
	move_and_slide(movement, Vector2.UP)
		
	update_animations()
		
	
func update_animations():
	if movement.x > 0:
		$AnimatedSprite.scale.x = 1.5
	elif movement.x < 0:
		$AnimatedSprite.scale.x = -1.5
	if is_on_floor():
		if abs(movement.x) > 0:
			if dano != 1:
				$AnimatedSprite.play("walk")
		else:
			if dano != 1:
				$AnimatedSprite.play("idle")
		
	
		
			if movement.y < 0:
				$AnimatedSprite.play("jump")
			
			



