extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flag = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Socket.connect_to_server()
	get_node("ultraNinja")._enter_scene()
	$ultraNinja/Camera2D.limit_bottom = 600
	$ultraNinja/Camera2D.limit_left = 0
	$ultraNinja/Camera2D.limit_right = 1344
	$ultraNinja/Camera2D.limit_top = 75
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Godzilla_end():
	$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	if flag == 0:
		$ultraNinja/CanvasLayer/ColorRect/AnimationPlayer.play("transitionLVL")
		yield($ultraNinja/CanvasLayer/ColorRect/AnimationPlayer,"animation_finished")
		flag = 1
	get_tree().change_scene("res://Scenes/CUTSCENE4AMOR/MWORLDGREAT.tscn")	
	pass # Replace with function body.
