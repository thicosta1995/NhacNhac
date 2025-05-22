extends Node

var turn:int = 0

var grab:bool =false
var todosBonecos = []
var todosEspaços = []
var trocarTurno
var segundos:float
var finalizarTurno:bool = false
var coldown:bool =false
@onready var timer = $ContagemTimer
#var dadosBonecos
#var dadosEspacos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	

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
			
#	pass # Replace with function body.
	for todosBoneco in todosBonecos:
		if todosBoneco is CharacterBody2D:
			
			var pos = todosBoneco.global_position
			var valor = todosBoneco.valor	
			
			var time = todosBoneco.time
			
			print("Inimigo: ", todosBoneco.name)
			print("  Posição: ", pos)
			print("  Valor: ", valor)
			print("  Time: ", time)
	

	todosEspaços =get_tree().get_nodes_in_group("Espacos")

	for todosEspaço in todosEspaços:
		if todosEspaço is Area2D:
			var posEspaco = todosEspaço.global_position

			print("espaco: ", posEspaco) 
#	for espaco in armanezamento_Espacos.get_children():
#		if espaco.has_method("get"):
#			dadosEspacos ={
#				"Posição": espaco.positionTabuleiro
#			}
#x'			todosEspaços.append(dadosEspacos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Troca"):
		#if turn == 0:
			#turn = 1
		#else :
			#turn =0
	#
		#print(turn)
	#_trocarTurno()
	pass
func _physics_process(delta: float) -> void:	
	_trocarTurno()
	
func get_turn():
	return turn
func _trocarTurno()-> void:
	if finalizarTurno == true and coldown == false:
		if turn == 0:
			turn = 1
		else :
			turn =0
			
		coldown = true
		timer.start(1.0)
		print(turn)


func _on_button_button_up() -> void:
	finalizarTurno = true
	pass # Replace with function body.





func _on_contagem_timer_timeout() -> void:
	finalizarTurno = false
	coldown = false
	print("entrou")
	pass # Replace with function body.
