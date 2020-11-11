extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Node2D/Camera2D.limit_bottom = 1025
	$Node2D/Camera2D.limit_right = 1984
	$Node2D/Camera2D.limit_left = 32
	$Node2D/Camera2D.limit_top = 0
	pass # Replace with function body.


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$Node2D/Camera2D.limit_bottom = 2335
		$Node2D/Camera2D.limit_right = 4415
	pass # Replace with function body.
