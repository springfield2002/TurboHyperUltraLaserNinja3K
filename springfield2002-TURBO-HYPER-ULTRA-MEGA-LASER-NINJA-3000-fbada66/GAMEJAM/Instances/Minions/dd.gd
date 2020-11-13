extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal change

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func _process(delta):
	$AnimatedSprite.play("idle")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Control_change():
	emit_signal("change")
	pass # Replace with function body.
