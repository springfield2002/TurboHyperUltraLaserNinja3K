extends Control

var dialog = [
	'UMA GRANDE CATÁSTROFE ESTÁ PARA ASSOLAR A TERRA',
	'VINDO DO ESPAÇO, UMA CALAMIDADE SE PREPARA PARA ABALAR A TERRA',
	'E SÓ O NOSSO HERÓI PODERÁ ACABAR COM ESSA AMEAÇA',
	'                                  SONIC LASER SPEEDWAGON'
]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

func _process(delta):
	$"next-indicator".visible = finished
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
		get_tree().change_scene("res://Scenes/MENU.tscn")
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
