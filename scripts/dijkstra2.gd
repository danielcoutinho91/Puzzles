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
	
	for i in buttons.size():
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
		buttons[i].disabled = true
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	board = rng.randi_range(0, 1)
	
	if board == 0:
		correct_button_sequence = [0, 3, 2, 6, 9]
		labels_values = ["9", "5", "3", "1", "8", "2", "4", "4", "7"]
		$RichTextLabel2.text = "Origem: INÍCIO ROTA ACESSÍVEL UNIFOR\nDestino: BLOCO K"
		
	elif board == 1:
		correct_button_sequence = [9, 7, 5, 3, 0]
		labels_values = ["2", "4", "1", "3", "2", "6", "4", "9", "4"]
		$RichTextLabel2.text = "Origem: BLOCO K\nDestino: INÍCIO ROTA ACESSÍVEL"
	
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