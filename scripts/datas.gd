extends Node2D

var buttons = []
var labels = []
var labels_values = []
var correct_dates_sequence = []
var next_correct_date = 0
var qt_dates = 4
var facts = []
var facts_selected = []
var dates = []
var dates_selected = []
var index = 0

signal end_game(value)

var facts_dict = {
	"Criação da primeira CALCULADORA por Blaise Pascal": 1642, 
	"Criação da CALCULADORA de Leibniz": 1671, 
	"Criação do SISTEMA BINÁRIO por George Boole": 1847, 
	"Criação do CARTÃO PERFURADO por Herman Hollerith": 1886, 
	"Criação do primeiro COMPUTADOR do mundo por Vannevar Bush": 1930, 
	"Ocorrência do primeiro BUG da história": 1945,
	"Criação do ENIAC, primeiro COMPUTADOR DIGITAL ELETRÔNICO do mundo, por John Eckert e John Mauchly": 1946,
	"Criação do primeiro VIDEOGAME por William Higinbotham": 1958, 
	"A criação do DISCO RÍGIDO": 1962,
	"Invenção do MOUSE por Douglas Engelbart": 1963,
	"Criação da ARPANET, primeira rede operacional de computadores apenas para militares": 1969,
	"Primeira utilização do termo INTERNET, por Vinton Cerf": 1970,
	"Criação do primeiro VÍRUS de computador, o The Creeper": 1971,
	"Primeira conexão intercontinental é realizada entre Estados Unidos e Noruega": 1973,
	"Fundação da MICROSOFT por Bill Gates e Paul Allen": 1975,
	"Criada a Usenet, rede informal de compartilhamento de notícias e artigos": 1979,	
	"Criação do primeiro COMPUTADOR PORTÁTIL por Adam Osborne": 1981,
	"Lançamento do sistema operacional WINDOWS 1.0 pela Microsoft": 1985,
	"Criação da WORLD WIDE WEB por Tim Berners-Lee": 1989,
	"Primeira conexão à rede mundial de computadores oferecida comercialmente no Brasil": 1995
}

func _ready():	
	buttons.append($Button1)
	buttons.append($Button2)
	buttons.append($Button3)
	buttons.append($Button4)
	
	for i in buttons.size():
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]])
	
	facts = facts_dict.keys()
	dates = facts_dict.values()
	
	var rng = RandomNumberGenerator.new()
	
	
	var i = 0
	var date_index = 0
	while(i < qt_dates):
		rng.randomize()
		date_index = rng.randi_range(0, facts_dict.size()-1)
		if !(dates[date_index] in dates_selected):
			dates_selected.append(dates[date_index]) 
			facts_selected.append(facts[date_index])
			i += 1
	
	i = 0
	for button in buttons:
		button.text = facts_selected[i]
		i += 1
	
	dates_selected.sort()
	correct_dates_sequence = dates_selected

func buttons_answer(button) -> void:	
	next_correct_date = correct_dates_sequence[index]
	index+= 1
	
	if facts_dict[button.text] != next_correct_date:
		button.modulate = Color('#FF2400')
		button.text = str(facts_dict[button.text], " - ", button.text)
		button.disabled = true
		
		for b in buttons:
			if b.disabled == false:
				b.text = str(facts_dict[b.text], " - ", b.text)
			b.disabled = true
			
		print("PERDEU")
		emit_signal("end_game", false)
	else:
		button.modulate = Color('#00FF7F')
		button.text = str(facts_dict[button.text], " - ", button.text)
		button.disabled = true
	
		if correct_dates_sequence.size() == index:
			for b in buttons:
				b.disabled = true
			print("VENCEU")
			emit_signal("end_game", true)
	
	

