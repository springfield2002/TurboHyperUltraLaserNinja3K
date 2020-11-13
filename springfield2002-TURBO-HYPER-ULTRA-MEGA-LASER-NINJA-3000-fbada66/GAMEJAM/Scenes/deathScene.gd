extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Button3_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().quit()

	pass # Replace with function body.
