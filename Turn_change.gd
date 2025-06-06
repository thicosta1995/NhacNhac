extends Node

@export var turn:int = 0

var grab:bool =false

var todosBonecos = []
var todosEspaços = [] 
var nâoPodeMexer:bool = false
var trocarTurno
var colocouApeca:bool = false
var jogadorPegPeca:bool = false
var pecaEscolhida:Node2D
var espaçoEscolhido:Node2D
var especo_x:float
var espaco_y:float
var timerAtual:float
var timerAtiva:float =0.5
var PosPecaSegurado:Vector2
var PosLargouApeca:Vector2
var registrar:bool= false
var valorDaUltimaPeca:int
var segundos:float
var finalizarTurno:bool = false
var bonecos_filtrados:Array = [CharacterBody2D] 
var espacos_filtrados:Array = [Area2D] 
var EspacoPosX: float
var EspacoPosy:float
var ultimaPeca:Node2D
var ultimoEspaco:Node2D
var coldown:bool=false
@onready var timer = $ContagemTimer
@onready var ain = $Main
#var dadosBonecos
#var dadosEspacos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tabuleiro  # Isso será preenchido pelo script do tabuleiro

	todosBonecos =get_tree().get_nodes_in_group("Boneco")

	print("Inimigos encontrados: ", todosBonecos.size())


	#for boneco in bonecos.get_children():
	#	if boneco.has_method("get"):
	#		dadosBonecos = {
	#			"valor": boneco.valor,
	#			"Jogador":boneco.time,
	#			"Nome":boneco.namePlay
	#		}
#
#			todosBonecos.append(dadosBonecos)		
			
func _process(delta: float) -> void:
	if colocouApeca == true:
		finalizarTurno = true
		registrar = true
	if coldown == true :
		timerAtual += delta*0.1
		print(timerAtual)
	

	if coldown:
		timerAtual += 0.1
		if timerAtual >= timerAtiva:
			coldown = false
			timerAtual = 0
		
func _trocarTurno() -> void:
	if colocouApeca and not coldown== true and registrar ==false:
		turn = 1 - turn  # Alterna entre 0 e 1
		coldown = true
		colocouApeca = false
		print("Turno trocado. Novo turno:", turn)


	
	
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.


	








func _on_contagem_timer_timeout() -> void:
	finalizarTurno = false
	coldown = false

	pass # Replace with function body.


func _on_button_button_up() -> void:
	finalizarTurno = true
	pass # Replace with function body.


func _on_button_button_down() -> void:
	finalizarTurno = true
	pass # Replace with function body.
