extends Node

var turn:int = 0

var grab:bool =false
var todosBonecos = []
var todosEspaços = [] 
var nâoPodeMexer:bool = false
var trocarTurno
var colocouApeca:bool = false
var segundos:float
var finalizarTurno:bool = false
var bonecos_filtrados:Array = [CharacterBody2D] 
var espacos_filtrados:Array = [Area2D] 
var coldown:bool =false
@onready var timer:Timer = $ContagemTimer
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
	for boneco in todosBonecos:
		if boneco is CharacterBody2D:
			bonecos_filtrados.push_front(boneco) 
			print("Inimigo: ", boneco.name)
			print("  Posição: ", boneco.global_position)
			print("  Valor: ", boneco.valor)
			print("  Time: ", boneco.time)
			
		

	todosEspaços =get_tree().get_nodes_in_group("Espaco")

	for espaco in todosEspaços:
		if espaco is Area2D:
			espacos_filtrados.push_front(espaco)
			print("espaco: ", espaco.position) 
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
	
func set_turn(value:bool):
	value = finalizarTurno
	
func _trocarTurno()-> void:
	if finalizarTurno == true and coldown == false:
		colocouApeca = false
		
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

	pass # Replace with function body.
