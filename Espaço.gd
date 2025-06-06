extends Area2D
signal jogada_feita(x: int, y: int, jogador: int, valor: int)
@export var player: bool = true
var tabuleiro = preload("res://Turn_change.gd")
@warning_ignore("shadowed_global_identifier")
var boneco = preload("res://area_boneco.tscn")
@export var qplayer: int
var valor_Player: int
var podeAdicionar:bool
var bodies_in_area: Array[CharacterBody2D] = []
var bodies_armazen: Array[CharacterBody2D] = []
var esperarTurno
@export var maiorValor:int
var jaColocouApeca:bool = false
var ocupado:bool = false
@export var pecaEmCima:bool= false
var positionTabuleiro:Vector2
var namePlay:String
var posPeca:Vector2
var turnchage = TurnChange
@export var turno:bool=false
@export var initial_position : Vector2
var qualturno:bool
var jogador:int =0
var valor:int=0
var colocouetirou:bool = false
var quantasPeçasGuardadas:int = 0
@export var grid_x: int
@export var grid_y: int
var gameobject = self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positionTabuleiro = position
	

	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("Boneco"):
		#if body.has_variable("pegou_peca"):
		
		namePlay = body.name
		bodies_in_area.push_front(body)
		print(body.valor)
		print(body.pegou_peca)
		print(namePlay)
		pecaEmCima= true
		valor_Player = body.valor
		
		
		
	
#func fazer_algo(node: Node2D) -> void:
	
	#if turnchage.grab == false and ocupado == false:
	#	node.global_position = global_position

	

#func _armazenarDados()->void

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	TurnChange.valorDaUltimaPeca = maiorValor
	
	armazenar_fimTurno()
		


	if pecaEmCima== true and TurnChange.grab == false  and  TurnChange.colocouApeca ==false:  
		if bodies_in_area.size() == 0:
			return

		var peca = bodies_in_area[-1]

		if bodies_armazen.is_empty():
			peca.global_position = global_position
			peca.podemexer = false
			peca.ocupado = true
			peca.armazen_de_espaco.append(self)
			bodies_armazen.append(peca)
			quantasPeçasGuardadas = quantasPeçasGuardadas +1
			valor_Player = peca.valor
			TurnChange.ultimaPeca = peca
			TurnChange.ultimoEspaco = self
			TurnChange.especo_x = self.global_position.x
			TurnChange.espaco_y = self.global_position.y
			print("espaco colocada",TurnChange.ultimoEspaco)
			print("peça colocada",TurnChange.ultimaPeca)
			colocouetirou = true
			jaColocouApeca = true
			turno =true
			emit_signal("jogada_feita", grid_x, grid_y, jogador, valor)
			TurnChange.colocouApeca = true
			TurnChange.PosLargouApeca = global_position
			bodies_in_area.clear()
			valor = bodies_armazen.back().valor
			jogador = bodies_armazen.back().time

		else:
			var podeColocar = true
			for item in bodies_armazen:
				if peca.valor <= item.valor:
					podeColocar = false
					break
				else:
					maiorValor = peca.valor
					peca.global_position = global_position
					
					bodies_armazen.append(peca)
					quantasPeçasGuardadas = quantasPeçasGuardadas +1
					TurnChange.ultimaPeca = peca
					valor_Player = maiorValor
					jaColocouApeca = true
					turno = true
					TurnChange.ultimoEspaco = self
					colocouetirou= true
					print("nome ultimo  ",TurnChange.ultimoEspaco)
					TurnChange.espaco_y = self.global_position.y
					TurnChange.especo_x = self.global_position.x
					TurnChange.colocouApeca = true
			
					TurnChange.PosLargouApeca = global_position
					valor = bodies_armazen.back().valor
					jogador = bodies_armazen.back().time
					bodies_in_area.clear()
					
		for item in bodies_armazen:
			if item.valor < maiorValor:
				
				item.podemexer = false
			elif item.valor >= maiorValor:
					item.podemexer = true
					item.ocupado = false
	# corrige aqui
		
			armazenar_fimTurno()
	pass
func _input(event: InputEvent) -> void:
	if event.is_action_released("Troca"):
		jaColocouApeca =! jaColocouApeca
		print(jaColocouApeca)
func armazenar_fimTurno()->void:
	if TurnChange.colocouApeca== true:
		if colocouetirou == true:
			for item in bodies_armazen:
				if item.valor < maiorValor:
					
					item.podemexer = false
					item.ocupado = true
				
				elif item.valor >= maiorValor:
					item.podemexer = true
					item.ocupado = false
	

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Boneco"):
		#fazer_algo(body)
		var index = bodies_in_area.find(body)
		if bodies_armazen.back() == body:
			bodies_armazen.pop_back()
			colocouetirou = true
			quantasPeçasGuardadas = quantasPeçasGuardadas -1
			if bodies_armazen.is_empty():
				maiorValor =0
			else:
				maiorValor = bodies_armazen.back().valor
		
		bodies_in_area.pop_back()
		pecaEmCima= false
	pass # Replace with function body.


func _on_button_button_up() -> void:
	#qualturno = turnchage.get_turn()
	#
	
	pass # Replace with function body.
