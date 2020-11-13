extends Control

var dialog = [
	'APÓS UMA INTENSA BATALHA, SPEEDWAGON, AGORA CONHECIDO MUNDIALMENTE COMO ULTRA NINJA, ',
	'CONSEGUIU A VITÓRIA SOBRE AS FORÇAS DO MAL. ULTRA NINJA VOLTA A SUA VIDA NORMAL, PORÉM PREPARADO PARA QUALQUER SITUAÇÃO                                       ',
	'AGORA EM SEUS MOMENTOS DE PAZ, ULTRA NINJA IRÁ TOMAR SUA UP COLA TRANQUILAMENTE E E NAS HORAS VAGAS... ',
	'                                        DAR UMA TUNADA!'
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
