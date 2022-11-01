extends Node2D

var buttons = []
var labels = []
var correct_button_sequence = []
var board = 0
var next_correct_button = 0
var index = 0

func _ready():
	buttons.append($Button0)
	buttons.append($Button1)
	buttons.append($Button2)
	buttons.append($Button3)
	buttons.append($Button4)
	buttons.append($Button5)
	
	for i in buttons.size():
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
	
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
		labels[0].text = "9"
		labels[1].text = "5"
		labels[2].text = "3"
		labels[3].text = "1"
		labels[4].text = "8"
		labels[5].text = "2"
		labels[6].text = "4"
		labels[7].text = "4"
		labels[8].text = "7"
		
	elif board == 1:
		correct_button_sequence = [0, 1, 3, 4, 5]
		labels[0].text = "2"
		labels[1].text = "4"
		labels[2].text = "1"
		labels[3].text = "3"
		labels[4].text = "2"
		labels[5].text = "6"
		labels[6].text = "4"
		labels[7].text = "9"
		labels[8].text = "4"
	
	else:
		correct_button_sequence = [0, 2, 3, 5]
		labels[0].text = "1"
		labels[1].text = "2"
		labels[2].text = "1"
		labels[3].text = "4"
		labels[4].text = "2"
		labels[5].text = "7"
		labels[6].text = "4"
		labels[7].text = "6"
		labels[8].text = "3"
	
	print(correct_button_sequence)
	
func buttons_answer(button) -> void:	
	next_correct_button = correct_button_sequence[index]
	index+= 1
	
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
