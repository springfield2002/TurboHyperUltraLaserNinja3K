extends Area2D

signal life(amount)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Node2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("life", 5)
		queue_free()
	pass # Replace with function body.


