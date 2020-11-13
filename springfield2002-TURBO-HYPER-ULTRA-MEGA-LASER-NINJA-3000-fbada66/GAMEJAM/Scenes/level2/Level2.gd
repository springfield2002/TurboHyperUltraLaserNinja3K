extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Socket.connect_to_server()
	$UltraNinja._enter_scene()
	$UltraNinja/Camera2D.limit_bottom = 1025
	$UltraNinja/Camera2D.limit_right = 1984
	$UltraNinja/Camera2D.limit_left = 32
	$UltraNinja/Camera2D.limit_top = 0
	pass # Replace with function body.


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$UltraNinja/Camera2D.limit_bottom = 2335
		$UltraNinja/Camera2D.limit_right = 4415
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		$UltraNinja/CanvasLayer/ColorRect/AnimationPlayer.play("transitionLVL")
		yield($UltraNinja/CanvasLayer/ColorRect/AnimationPlayer, "animation_finished")		
		get_tree().change_scene("res://Scenes/level3/Level3.tscn")
	pass # Replace with function body.
