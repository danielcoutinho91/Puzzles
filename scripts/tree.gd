extends Node2D

var buttons = []
var correct_button_sequence = []
var next_correct_button = 0
var index = 0
var board = 0

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
	buttons.append($Button10)
	buttons.append($Button11)
	
	for i in buttons.size():
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	board = rng.randi_range(0, 2)
	
	if board == 0:
		$RichTextLabel.text = "Percorra a árvore de busca binária PRÉ-ORDEM"
		correct_button_sequence = [0, 1, 3, 7, 8, 4, 9, 2, 5, 10, 6, 11]
		
	elif board == 1:
		$RichTextLabel.text = "Percorra a árvore de busca binária EM-ORDEM"
		correct_button_sequence = [7, 3, 8, 1, 4, 9, 0, 10, 5, 2, 6, 11]
	
	else:
		$RichTextLabel.text = "Percorra a árvore de busca binária PÓS-ORDEM"
		correct_button_sequence = [7, 8, 3, 9, 4, 1, 10, 5, 11, 6, 2, 0]
	
func buttons_answer(button) -> void:	
	next_correct_button = correct_button_sequence[index]
	index+= 1
	
	if button.get_name() != buttons[next_correct_button].get_name():
		button.modulate = Color('#FF2400')
		for b in buttons:
			b.disabled = true
		print("PERDEU")
	else:
		button.modulate = Color('#00FF7F')
		button.disabled = true
	
		if correct_button_sequence.size() == index:
			for b in buttons:
				b.disabled = true
			print("VENCEU")
