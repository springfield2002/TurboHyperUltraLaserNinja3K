extends Control

signal change

var dialog = [
	'VOCÊ ESTÁ PASSANDO POR MAUS BOCADOS, AMIGO',
	'EU PODIA TE DAR UM DOLLYNHO PRA MELHORAR',
	'MAS NÃO SERÁ SUFICIENTE',
	'                                  VAMOS DAR UMA TUNADA'
]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

func _process(delta):
	$Sprite.visible = finished
	if self.visible == true:
		if Input.is_action_just_pressed("ui_accept"):
			load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		emit_signal("change")
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true



func _on_Area2D_body_entered(body):
	if body.name == "speedwagon":
		self.visible = true
		pass # Replace with function body.
