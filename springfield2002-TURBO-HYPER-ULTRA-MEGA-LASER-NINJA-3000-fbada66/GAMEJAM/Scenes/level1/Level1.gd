extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Socket.connect_to_server()
	$speedwagon/Camera2D.limit_left = 0
	$speedwagon/Camera2D.limit_top = 0
	$speedwagon/Camera2D.limit_right = 1024
	$speedwagon/Camera2D.limit_bottom = 600
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body._exit_scene()
		
		body.position.x = 1228.78
		body.position.y = 523.89
		
		$speedwagon/Camera2D.limit_left = 1152
		$speedwagon/Camera2D.limit_right = 4256
		$speedwagon/Camera2D.limit_bottom = 670
		body._enter_scene()
	pass # Replace with function body.



func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		$speedwagon/CanvasLayer/AnimationPlayer.play("transitionLVL")
		yield($speedwagon/CanvasLayer/AnimationPlayer,"animation_finished")
		get_tree().change_scene("res://Scenes/level2/Level2.tscn")
	


