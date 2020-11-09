extends KinematicBody2D



export  var movement = Vector2(0,0)
export var speed  = 100
export var jump = 500
export var gravity = 10
var second_jump = 3
var dano = 0
var attack = 0
var move = 1
var down = 1

export var life = 5
signal hit
var eixo_horizontal

func _ready():
	pass


func _physics_process(delta):
	if !is_on_floor():
		movement.y += gravity
		
	if Input.is_action_just_pressed("jump"):	
	
		if is_on_floor():
			movement.y = -jump
		
	
	eixo_horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement.x = eixo_horizontal * speed
	
	if is_on_ceiling():
		movement.y = 0
		
	move_and_slide(movement, Vector2.UP)
		
	update_animations()
		
	
func update_animations():
	if movement.x > 0:
		$AnimatedSprite.scale.x =1.5
		$"basic ATK/CollisionShape2D".scale.x = 1
		if $airslash/airslash.position.x < 0:
			$airslash/airslash.position.x *= -1
	elif movement.x < 0:
		$AnimatedSprite.scale.x = -1.5
		$"basic ATK/CollisionShape2D".scale.x = -1
		if $airslash/airslash.position.x > 0:
			$airslash/airslash.position.x *= -1
	
	if is_on_floor():
		if abs(movement.x) > 0:
			if dano != 1:
				$AnimationPlayer.play("walking")
				
		else:
			if Input.is_action_pressed("down") and down == 1:
				$AnimationPlayer.stop()
				$AnimationPlayer.play("abaixar")
				yield($AnimationPlayer, "animation_finished")
				$AnimatedSprite.play("DUCKED")
				
			
			if Input.is_action_just_released("down") and down == 0:
				$AnimationPlayer.play_backwards("abaixar")
				yield($AnimationPlayer, "animation_finished")
				down = 1
			else:
				if dano != 1:
					$AnimationPlayer.play("idle")
	
	
	
	if Input.is_action_just_pressed("jump"):
		$AnimationPlayer.stop()
		$AnimatedSprite.play("jump")
			
	if Input.is_action_pressed("attack"):
		$AnimationPlayer.stop()
		dano = 1
		if !is_on_floor():
			if movement.x > 0:
				$AnimationPlayer.play("airslash")
				yield($AnimationPlayer, "animation_finished")
				dano = 0
			if movement.x < 0:
				$AnimationPlayer.play("airslash(L)")
				yield($AnimationPlayer, "animation_finished")
				dano = 0
			
		else:
			dano = 1
			if movement.x > 0:
				$AnimationPlayer.play("strongATK")	
			
			if movement.x < 0:
				$AnimationPlayer.play("strongATK (L)")	
		
		yield($AnimationPlayer, "animation_finished")
		dano = 0
		
	



