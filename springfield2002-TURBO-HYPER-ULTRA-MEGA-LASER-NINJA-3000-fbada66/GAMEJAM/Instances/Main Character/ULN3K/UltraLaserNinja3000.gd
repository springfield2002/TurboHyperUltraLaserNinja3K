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
const laser = preload("res://Instances/Main Character/tiro.tscn")
onready var life = $CanvasLayer
signal hit
var eixo_horizontal

func _ready():
	Socket.connect("cima", self, "jump")
	Socket.connect("esquerda", self, "_on_esquerda")
	Socket.connect("direita", self, "_on_direita")
	Socket.connect("ataque", self, "_on_ataque")
	Socket.connect("parado", self, "_stop")
	Socket.connect("sprint", self, "_dash")
	Socket.connect("shoot", self, "_shoot")
	Socket.connect("duck",self, "_duck")
	Socket.connect("unduck",self, "_unduck")
	pass
	
	
#func _duck():	
	movement.x = 0
	dano = 1
	if down == 1:
		$AnimationPlayer.play("abaixar")
		yield($AnimationPlayer,"animation_finished")
		down = 0

#func _unduck():
	$AnimationPlayer.play_backwards("abaixar")	
	yield($AnimationPlayer,"animation_finished")
	dano = 0
	down = 1
		
func _shoot():
	movement.x = 0
	dano = 1
	$AnimationPlayer.play("shoot")
	yield($AnimationPlayer,"animation_finished")
	
	var cloudattack = laser.instance()
	if sign($Position2D.position.x) == 1:
		cloudattack.set_direction(1)
	else:
		cloudattack.set_direction(-1)
	get_parent().add_child(cloudattack)
	cloudattack.position = $Position2D.global_position
	dano = 0	
	
func _on_ataque():
	dano = 1
	if !is_on_floor():
		if $AnimatedSprite.scale.x > 0:
			$AnimationPlayer.play("airslash")
			yield($AnimationPlayer, "animation_finished")
			dano = 0
		if $AnimatedSprite.scale.x < 0:
			$AnimationPlayer.play("airslash(L)")
			yield($AnimationPlayer, "animation_finished")
			dano = 0
		
	else:
		dano = 1
		if $AnimatedSprite.scale.x > 0:
			$AnimationPlayer.play("strongATK")	
			yield($AnimationPlayer, "animation_finished")
			dano = 0
	
		if $AnimatedSprite.scale.x < 0:
			$AnimationPlayer.play("strongATK (L)")	
			yield($AnimationPlayer, "animation_finished")
			dano = 0

func jump():
	if is_on_floor():
			movement.y = -jump
			$AnimationPlayer.stop()
			$AnimatedSprite.play("jump")

func _stop():
	if dano != 1:
		eixo_horizontal = 0
		speed = 100

func _on_esquerda():
	if dano != 1:
		eixo_horizontal = -1

func _on_direita():
	if dano != 1:
		eixo_horizontal = 1
func _dash():
	if abs(movement.x) > 0 and dano != 1:
		$AnimationPlayer.stop()
		$AnimatedSprite.play("dash")
		speed = 500

func _physics_process(delta):
	if !is_on_floor():
		movement.y += gravity
		if movement.y > 0 && attack == 0:
			$AnimationPlayer.stop()
			$AnimatedSprite.play("fall")
	
	if Input.is_action_just_pressed("jump"):	
		if is_on_floor():
			movement.y = -jump
		
	if dano != 1:
		eixo_horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
		movement.x = eixo_horizontal * speed
	
	if is_on_ceiling():
		movement.y = 0
		
	move_and_slide(movement, Vector2.UP)
		
	update_animations()
		
	if eixo_horizontal == -1:
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	if eixo_horizontal == 1:
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	
	if Input.is_action_pressed("shoot"):
		movement.x = 0
		dano = 1
		$AnimationPlayer.play("shoot")
		yield($AnimationPlayer,"animation_finished")
		
		var cloudattack = laser.instance()
		if sign($Position2D.position.x) == 1:
			cloudattack.set_direction(1)
		else:
			cloudattack.set_direction(-1)
		get_parent().add_child(cloudattack)
		cloudattack.position = $Position2D.global_position
		dano = 0
	
	if Input.is_action_just_released("shoot"):
		$AnimationPlayer.play("release_shot")
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
	
	if !is_on_floor():
		if dano != 1:
			$AnimationPlayer.play("jump")
	
	
	if is_on_floor():
		if abs(movement.x) > 0 and dano != 1:
			$AnimationPlayer.play("walking")
			
			if Input.is_action_pressed("dash"):
				
				$AnimationPlayer.stop()
				$AnimatedSprite.play("dash")
				speed = 500
		if Input.is_action_just_released("dash"):
			speed = 100
				
		if Input.is_action_pressed("down") or Input.is_action_just_pressed("down"):
			movement.x = 0
			dano = 1
			if down == 1:
				$AnimationPlayer.play("abaixar")
				yield($AnimationPlayer,"animation_finished")
				down = 0
		
		if Input.is_action_just_released("down") and down == 0:
			$AnimationPlayer.play_backwards("abaixar")	
			yield($AnimationPlayer,"animation_finished")
			dano = 0
			down = 1
		
		if abs(movement.x) == 0 and dano != 1:
			$AnimationPlayer.play("idle")
	
	
	
	if Input.is_action_just_pressed("jump"):
		$AnimationPlayer.stop()
		$AnimatedSprite.play("jump")
			
	if Input.is_action_pressed("attack"):
		dano = 1
		if !is_on_floor():
			if $AnimatedSprite.scale.x > 0:
				$AnimationPlayer.play("airslash")
				yield($AnimationPlayer, "animation_finished")
				dano = 0
			if $AnimatedSprite.scale.x < 0:
				$AnimationPlayer.play("airslash(L)")
				yield($AnimationPlayer, "animation_finished")
				dano = 0
			
		else:
			dano = 1
			if $AnimatedSprite.scale.x > 0:
				$AnimationPlayer.play("strongATK")	
				yield($AnimationPlayer, "animation_finished")
				dano = 0
		
			if $AnimatedSprite.scale.x < 0:
				$AnimationPlayer.play("strongATK (L)")	
				yield($AnimationPlayer, "animation_finished")
				dano = 0
		

func _exit_scene():
	$CanvasLayer/ColorRect/AnimationPlayer.play("transition")	
	yield($CanvasLayer/ColorRect/AnimationPlayer, "animation_finished")
	pass

func _enter_scene():
	$CanvasLayer/ColorRect/AnimationPlayer.play_backwards("transition")	
	yield($CanvasLayer/ColorRect/AnimationPlayer, "animation_finished")
	pass		
 
func _on_Node2D_life(amount):
	life.set_current(life.current + amount)
	pass # Replace with function body.
