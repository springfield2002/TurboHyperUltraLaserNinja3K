extends KinematicBody2D

export  var movement = Vector2(0,0)
var player = null
var move = Vector2.ZERO
var speed = 1
var fire_direction
var bullet_speed = 100
export var attack_time = 1
onready var Shuriken = preload("res://Assets/Game_elements/Enemy/Ninja_Frog/Shuriken/Shuriken.tscn")
export var gravity = 100
var touch = 0

	
func _physics_process(delta):
	if player != null:
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO
	
func _on_Area2D_body_entered(body):
	if body.name == "speedwagon":
		player = body
	
func _on_Area2D_body_exited(body):
		player = null
		$AnimatedSprite.play("Idle")
	
func fire():
	var bullet = Shuriken.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(attack_time)
	$AnimatedSprite.play("Attack")
	yield(get_tree().create_timer(0.4), "timeout")
	$AnimatedSprite.play("Idle")
	
func _on_Timer_timeout():
	if player != null:
		fire()

func _on_Area2DLeft_body_entered(body):
	if body.name == "speedwagon":
		$AnimatedSprite.flip_h = false

func _on_Area2DRight_body_entered(body):
	if body.name == "speedwagon":
		$AnimatedSprite.flip_h = true
func dead():
	$AnimatedSprite.play("death")
