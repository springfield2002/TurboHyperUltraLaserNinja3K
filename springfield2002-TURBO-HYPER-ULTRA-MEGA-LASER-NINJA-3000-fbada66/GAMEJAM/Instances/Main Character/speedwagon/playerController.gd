extends KinematicBody2D


export  var movement = Vector2(0,0)
export var speed  = 100
export var jump = 500
export var gravity = 10
var second_jump = 3
var attack = 0
var dano = 0
onready var life = $CanvasLayer
signal hit
var eixo_horizontal = 0
var spin = 0
var shift = 0
var time = 0
func _ready():
	
	Socket.connect("ataque", self, "_on_ataque")

	pass
	

func _on_ataque():
	if !is_on_floor():
			attack = 1
			$AirSlash/CollisionShape2D.disabled = false
			$AnimationPlayer.stop()
			$AnimatedSprite.play("airslash")
		
	if is_on_floor() and movement.x == 0:
		dano = 1
		$AnimationPlayer.stop(true)
		$AnimatedSprite.rotation_degrees = 0
		$AnimationPlayer.play("ground_kick")
		yield($AnimationPlayer, "animation_finished")
		dano = 0
		attack = 0	

func _dash():		
	if abs(movement.x) > 0 and dano != 1 and shift != 1:
		dano = 1
		shift = 1
		$AirSlash/CollisionShape2D.disabled = false
		$AnimationPlayer.stop()
		$AnimatedSprite.play("airslash")
		spin = 1
		speed = 200
		while time < 5:
			time += 1*get_physics_process_delta_time()
			if time > 5:
				dano = 0
				time = 0
			
					
func _physics_process(delta):
	if dano != 1:
		eixo_horizontal = Input.get_action_strength("right") - Input.get_action_strength("left") 
		movement.x = eixo_horizontal * speed
	if !is_on_floor():
		movement.y += gravity
		if attack == 1:
			spin = 1
		if movement.y > 0 && attack == 0:
			$AnimationPlayer.stop()
			if shift != 1:
			  $AnimatedSprite.play("fall")

	if spin == 1:
		$AnimatedSprite.rotation_degrees += $AnimatedSprite.scale.x * 37.5

	if spin == 0:
		$AnimatedSprite.rotation_degrees = 0
		
	if is_on_floor():
		second_jump = 3
		if shift == 0:
			spin = 0
			$AirSlash/CollisionShape2D.disabled = true
			attack = 0
		
	
		if Input.is_action_just_pressed("jump"):	
			if is_on_floor():
				movement.y = -jump
				second_jump  -= 1
			if !is_on_floor() and second_jump > 0:
				movement.y = -jump
				second_jump  -= 1
	
		
	
	if is_on_ceiling():
		movement.y = 0
		
	move_and_slide(movement, Vector2.UP)
	
	
		
	update_animations()
		
	
func update_animations():
	if movement.x > 0:
		$AnimatedSprite.scale.x = 1.2
		if $ground_kick/CollisionShape2D.position.x < 0:
			$ground_kick/CollisionShape2D.position.x *= -1
	elif movement.x < 0:
		$AnimatedSprite.scale.x = -1.2
		if $ground_kick/CollisionShape2D.position.x > 0:
			$ground_kick/CollisionShape2D.position.x *= -1
	
	if is_on_floor():
		if abs(movement.x) == 0 and dano != 1:
			$AnimationPlayer.play("idle")
			shift = 0
			speed = 100
		if abs(movement.x) > 0 and dano != 1 and shift != 1:
			$AnimatedSprite.play("walk")
			
			if Input.is_action_pressed("dash"):
				dano = 1
				shift = 1
				$AirSlash/CollisionShape2D.disabled = false
				$AnimationPlayer.stop()
				$AnimatedSprite.play("airslash")
				spin = 1
				speed = 200
				while time < 5:
					time += 1*get_physics_process_delta_time()
				if time > 5:
					dano = 0
					time = 0
			
			if Input.is_action_just_released("dash"):
				dano = 0
				time = 0
				
	
	if Input.is_action_just_pressed("jump"):
		if shift != 1:
			$AnimatedSprite.play("jump")
			
	if Input.is_action_just_pressed("attack"):
		if !is_on_floor():
			attack = 1
			$AirSlash/CollisionShape2D.disabled = false
			$AnimationPlayer.stop()
			$AnimatedSprite.play("airslash")
			
		
		if is_on_floor() and movement.x == 0:
			dano = 1
			Socket.write_text("ataque\n")
			$AnimationPlayer.stop(true)
			$AnimatedSprite.rotation_degrees = 0
			$AnimationPlayer.play("ground_kick")
			yield($AnimationPlayer, "animation_finished")
			dano = 0
			attack = 0

func _exit_scene():
	$CanvasLayer/AnimationPlayer.play("transition")	
	yield($CanvasLayer/AnimationPlayer, "animation_finished")
	pass

func _enter_scene():
	$CanvasLayer/AnimationPlayer.play_backwards("transition")	
	yield($CanvasLayer/AnimationPlayer, "animation_finished")
	pass
func _on_Node2D_life(amount):
	life.set_current(life.current + 5)
	pass # Replace with function body.

func hit(value):
	$AnimationPlayer.stop()
	movement.x = 0
	$AnimatedSprite.play("hit")
	life.set_current(life.current - value)
	$AnimationPlayer.play("flash")
	$invincible.start()
func _on_invincible_timeout():
	$AnimationPlayer.stop()
	$CollisionShape2D.visible = true
	pass # Replace with function body.
