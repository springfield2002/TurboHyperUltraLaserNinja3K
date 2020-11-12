extends KinematicBody2D

export  var movement = Vector2(0,0)
var player = null
var move = Vector2.ZERO
var speed = 1
var fire_direction
var bullet_speed = 100
export var attack_time = 1.5
const laser = preload("res://Assets/Game_elements/Enemy/Ninja_Robot/Laser/Laser.tscn")
export var gravity = 100
var touch = 0
var direction = 0
func _ready():
	$AnimatedSprite.play("Idle")
	
func _on_Area2DLeft_body_entered(body):
	if body.name == "Node2D3":
		player = body
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = true
		direction = 0

func _on_Area2DLeft_body_exited(body):
	player = null
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.flip_h = true
		
		
func _on_Area2DRight_body_entered(body):
	if body != self:
		player = body
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = false
		direction = 1

func _on_Area2DRight_body_exited(body):
	player= null
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.flip_h = false

	
func fire():
	if direction == 1:
		var Laser = laser.instance()
		get_parent().add_child(Laser)
		Laser.position = $Right.global_position
		$Timer.set_wait_time(attack_time)
	
	if direction == 0:
		var Laser = laser.instance()
		get_parent().add_child(Laser)
		Laser.position = $Left.global_position
		Laser.set_shoot_direction(-1)
		$Timer.set_wait_time(attack_time)

	
func _on_Timer_timeout():
	if player != null:
		fire()



	


