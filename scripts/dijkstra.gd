extends Node2D

var buttons = []
var labels = []
var labels_values = []
var correct_button_sequence = []
var next_correct_button = 0
var index = 0
var board = 0
var game_started = 0

#signal finalJogo(retorno)

func _ready():
	buttons.append($Button0)
	buttons.append($Button1)
	buttons.append($Button2)
	buttons.append($Button3)
	buttons.append($Button4)
	buttons.append($Button5)
	buttons.append($Button6)
	buttons.append($Button7)
	buttons.append($Button8)
	buttons.append($Button9)
	
	labels.append($Label1)
	labels.append($Label2)
	labels.append($Label3)
	labels.append($Label4)
	labels.append($Label5)
	labels.append($Label6)
	labels.append($Label7)
	labels.append($Label8)
	labels.append($Label9)
	labels.append($Label10)
	labels.append($Label11)
	labels.append($Label12)
	labels.append($Label13)
	labels.append($Label14)
	labels.append($Label15)
	labels.append($Label16)
	labels.append($Label17)
	labels.append($Label18)
	
	for i in buttons.size():
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
		buttons[i].disabled = true	
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	board = rng.randi_range(0, 1)
	
	if board == 0:
		correct_button_sequence = [0, 3, 2, 6, 9]
		labels_values = ["85s", "3m", "2m", "2m", "20s", "90s", "90s", "2m", "3m", "3m", "60s", "2m", "2m", "1m", "30s", "2m", "1m", "40s"]
		$RichTextLabel2.text = "Origem: INÍCIO ROTA ACESSÍVEL UNIFOR\nDestino: BLOCO K"
		
	elif board == 1:
		correct_button_sequence = [9, 7, 5, 3, 0]
		labels_values = ["45s", "90s", "1m", "2m", "40s", "40s", "90s", "1m", "3m", "1m", "1m", "2m", "90s", "40s", "35s", "30s", "1m", "20s"]
		$RichTextLabel2.text = "Origem: BLOCO K\nDestino: INÍCIO ROTA ACESSÍVEL"
		
	for i in labels_values.size():
		labels[i].text = labels_values[i]
	
	buttons[correct_button_sequence.back()].modulate = Color("#FFFF00")
	buttons[correct_button_sequence[0]].disabled = false

func buttons_answer(button) -> void:	
	next_correct_button = correct_button_sequence[index]
	index+= 1
	
	if (game_started == 0):
		for b in buttons:
			b.disabled = false
			game_started = 1
	
	if button.get_name() != buttons[next_correct_button].get_name():
		button.modulate = Color('#FF2400')
		for b in buttons:
			b.disabled = true
		print("PERDEU")
		#emit_signal("finalJogo", false)	
	else:
		button.modulate = Color('#00FF7F')
		button.disabled = true
	
		if correct_button_sequence.size() == index:
			for b in buttons:
				b.disabled = true
			print("VENCEU")
			#emit_signal("finalJogo", true)	
