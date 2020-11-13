extends Node2D


# Declare member variables here. Examples:
# var a = 2
var ultraNinja = preload("res://Instances/Main Character/ULN3K/UltraLaserNinja3000.tscn")
var change = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Socket.connect_to_server()
	$speedwagon._enter_scene()
	$speedwagon/Camera2D.limit_bottom = 1025
	$speedwagon/Camera2D.limit_right = 1984
	$speedwagon/Camera2D.limit_left = 32
	$speedwagon/Camera2D.limit_top = 0
	pass # Replace with function body.


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$speedwagon/Camera2D.limit_bottom = 2335
		$speedwagon/Camera2D.limit_right = 4415
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		$speedwagon/CanvasLayer/AnimationPlayer.play("transitionLVL")
		yield($speedwagon/CanvasLayer/AnimationPlayer, "animation_finished")		
		get_tree().change_scene("res://Scenes/level3/Level3.tscn")
	pass # Replace with function body.


func _on_Node2D_change():
	if change == 0:
		var player = ultraNinja.instance()
		player.position = get_global_position()
		self.remove_child($speedwagon)
		self.add_child(player)
		change = 1
		
		
	pass # Replace with functionbody.
