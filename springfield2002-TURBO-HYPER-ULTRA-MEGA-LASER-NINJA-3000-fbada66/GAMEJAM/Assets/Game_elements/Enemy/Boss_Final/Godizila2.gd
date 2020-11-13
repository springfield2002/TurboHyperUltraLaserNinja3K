extends KinematicBody2D
var player = null
onready var laser = preload("res://Assets/Game_elements/Enemy/Boss_Final/Tele_Laser/Target_Laser.tscn")
onready var fireball = preload("res://Assets/Game_elements/Enemy/Boss_Final/Super Laser/Super_Laser.tscn")
var direction = false
var life = 10

func _on_Area2DLeft_body_entered(body):
	if body.name == "Node2D3":
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = true
		player = body
		direction = true
		


func _on_Area2DLeft_body_exited(body):
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.flip_h = true


func _on_Area2DRight_body_entered(body):
	if body.name == "Node2D3":
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = false
		player = body
		direction = false


func _on_Area2DRight_body_exited(body):
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.flip_h = false
	
func fire():
	var laser1 = laser.instance()
	var laser2 = laser.instance()
	var laser3 = laser.instance()
	
	if direction == false:
		$AnimatedSprite.set_frame(1)
		$AnimatedSprite.stop()
		laser1.position = $Right1.get_global_position()
		laser1.player = player
		get_parent().add_child(laser1)
		print(direction)
		yield(get_tree().create_timer(0.3), "timeout")
		laser2.position = $Right2.get_global_position()
		laser2.player = player
		get_parent().add_child(laser2)
		yield(get_tree().create_timer(0.3), "timeout")
		laser3.position = $Right3.get_global_position()
		laser3.player = player
		get_parent().add_child(laser3)
	
	if direction == true:
		$AnimatedSprite.set_frame(1)
		$AnimatedSprite.stop()
		laser1.position = $Left1.get_global_position()
		laser1.player = player
		get_parent().add_child(laser1)
		print(direction)
		yield(get_tree().create_timer(0.3), "timeout")
		laser2.position = $Left2.get_global_position()
		laser2.player = player
		get_parent().add_child(laser2)
		yield(get_tree().create_timer(0.3), "timeout")
		laser3.position = $Left3.get_global_position()
		laser3.player = player
		get_parent().add_child(laser3)

func fireball():
	var SP = fireball.instance()
	if direction == false:
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.play("SuperAttack")
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().add_child(SP)
		SP.position = $Right.global_position
	if direction == true:
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.play("SuperAttack")
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().add_child(SP)
		SP.position = $Left.global_position
		SP.set_shoot_direction(-1)
	pass	
	
func _on_Timer_timeout():
	if player != null:
		fire()
