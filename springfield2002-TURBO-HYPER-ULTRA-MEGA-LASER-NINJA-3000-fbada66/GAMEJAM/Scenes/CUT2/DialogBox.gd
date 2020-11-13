extends Control

var dialog = [
	'ENQUANTO REALIZAVA SUAS ATIVIDADES ROTINEIRAS A SERVIÇO DE SEU CLAN, SONIC LASER SPEEDWAGON PERCEBEU COISAS ESTRANHAS',
	'PERCEBEU QUE A TERRA ESTAVA SOBRE ATAQUE DE COISAS PODEROSAS E NUNCA ANTES VISTAS',
	'AO PERCEBER A FORÇA DO INIMIGO, NOSSO HERÓI FOI BUSCAR A AJUDA DE SEU AMIGO DOUTOR DOCTOR REY PARA...',
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
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
