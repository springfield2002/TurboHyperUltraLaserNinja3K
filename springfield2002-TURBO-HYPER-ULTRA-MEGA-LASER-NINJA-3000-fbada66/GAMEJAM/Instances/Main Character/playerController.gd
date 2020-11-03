extends KinematicBody2D


export  var movement = Vector2(0,0)
export var speed  = 100
export var jump = 300
export var gravity = 10
var second_jump = 3
var dano = 0
var attack = 0
export var life = 5
signal hit
var eixo_horizontal



func _physics_process(delta):
	if !is_on_floor():
		movement.y += gravity
		if attack == 1:
			$AnimatedSprite.rotation_degrees += $AnimatedSprite.scale.x * 37.5
		if movement.y > 0 && attack == 0:
			$AnimatedSprite.play("fall")

	else:
		second_jump = 3
		attack = 0
		$AnimationPlayer.stop(true)
		$AnimatedSprite.rotation_degrees = 0
		$AirSlash/CollisionShape2D.disabled = true
	if Input.is_action_just_pressed("jump"):	
		if is_on_floor():
			movement.y = -jump
			second_jump  -= 1
		if !is_on_floor() and second_jump > 0:
			movement.y = -jump
			second_jump  -= 1
	
	eixo_horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement.x = eixo_horizontal * speed
	
	if is_on_ceiling():
		movement.y = 0
		
	move_and_slide(movement, Vector2.UP)
		
	update_animations()
		
	
func update_animations():
	if movement.x > 0:
		$AnimatedSprite.scale.x = 1.2
	elif movement.x < 0:
		$AnimatedSprite.scale.x = -1.2
	if is_on_floor():
		if abs(movement.x) > 0:
			if dano != 1:
				$AnimatedSprite.play("walk")
		else:
			if dano != 1:
				$AnimatedSprite.play("idle")
		
	
		
	if Input.is_action_pressed("jump"):
		$AnimatedSprite.play("jump")
			
	if Input.is_action_pressed("attack"):
		attack = 1
		if !is_on_floor():
			$AirSlash/CollisionShape2D.disabled = false
			$AnimationPlayer.play("airslash")
		if is_on_floor() and eixo_horizontal == 0:
			
			$ground_kick/CollisionShape2D.disabled = false
			$AnimatedSprite.play("ground_kick")
			yield($AnimatedSprite, "animation_finished")
			$ground_kick/CollisionShape2D.disabled = true
		
