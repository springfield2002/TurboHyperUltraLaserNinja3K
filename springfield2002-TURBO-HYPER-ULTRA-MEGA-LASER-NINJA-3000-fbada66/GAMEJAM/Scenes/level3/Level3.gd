extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Node2D")._enter_scene()
	$ultraNinja/Camera2D.limit_bottom = 600
	$ultraNinja/Camera2D.limit_left = 0
	$ultraNinja/Camera2D.limit_right = 1344
	$ultraNinja/Camera2D.limit_top = 75
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
