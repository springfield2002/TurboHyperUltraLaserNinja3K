extends Node2D


func _on_QUIT_pressed():
	get_tree().quit()
	
func _on_PLAY_pressed():
	get_tree().change_scene("res://Scenes/level1/LEVEL_1.tscn")

