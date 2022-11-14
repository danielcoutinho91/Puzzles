extends Node2D

var buttons = []
var labels = []
var labels_values = []
var correct_button_sequence = []
var next_correct_button = 0
var index = 0
var board = 0
var game_started = 0

signal finalJogo(retorno)

func _ready():
	buttons.append($Button0)
	buttons.append($Button1)
	buttons.append($Button2)
	buttons.append($Button3)
	buttons.append($Button4)
	buttons.append($Button5)
	
	for i in buttons.size():
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
		buttons[i].disabled = true
	
	buttons[0].disabled = false
	
	labels.append($Label0)
	labels.append($Label1)
	labels.append($Label2)
	labels.append($Label3)
	labels.append($Label4)
	labels.append($Label5)
	labels.append($Label6)
	labels.append($Label7)
	labels.append($Label8)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	board = rng.randi_range(0, 2)
	
	if board == 0:
		correct_button_sequence = [0, 2, 1, 3, 5]
		labels_values = ["9", "5", "3", "1", "8", "2", "4", "4", "7"]
		
	elif board == 1:
		correct_button_sequence = [0, 1, 3, 4, 5]
		labels_values = ["2", "4", "1", "3", "2", "6", "4", "9", "4"]
	
	else:
		correct_button_sequence = [0, 2, 3, 5]
		labels_values = ["1", "2", "1", "4", "2", "7", "4", "6", "3"]
		
	for i in labels.size():
		labels[i].text = labels_values[i]
			

func buttons_answer(button) -> void:
	emit_signal("finalJogo", true)	
	next_correct_button = correct_button_sequence[index]
	index+= 1
	
	if (game_started == 0):
		for b in buttons:
			b.disabled = false
			game_started = 1
	
	if button.get_name() != buttons[next_correct_button].get_name():
		print("PERDEU")
		button.modulate = Color('#FF2400')
		for b in buttons:
			b.disabled = true
	else:
		button.modulate = Color('#00FF7F')
		button.disabled = true
	
		if correct_button_sequence.size() == index:
			print("VENCEU")
			for b in buttons:
				b.disabled = true
