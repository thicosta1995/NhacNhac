extends Area2D

@export var player: bool = true
var tabuleiro = preload("res://Turn_change.gd")
var boneco = preload("res://area_boneco.tscn")
@export var qplayer: int
var valor_Player: int
var podeAdicionar:bool
var bodies_in_area: Array[CharacterBody2D] = []
var bodies_armazen: Array[CharacterBody2D] = []
var esperarTurno
var jaColocouApeca:bool = false
var ocupado:bool = false
var pecaEmCima:bool= false
var positionTabuleiro:Vector2
var namePlay:String
var posPeca:Vector2
var turnchage = TurnChange
var turno:bool=false
@export var initial_position : Vector2
var qualturno:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positionTabuleiro = position
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		print("Overlapping with: ", area.name)
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

func _process(delta: float) -> void:
#	armazenar_fimTurno()
	
	turnchage.set_turn(turno) 
	
	if qualturno == true:
		turnchage.colocouApeca = false

	
	if pecaEmCima == true and turnchage.grab == false and turnchage.colocouApeca ==false:
		if bodies_armazen.is_empty():
			bodies_in_area[-1].global_position = global_position
			bodies_in_area[-1].podemexer = false
			bodies_armazen = bodies_in_area.duplicate()
			turnchage.colocouApeca = true
			
		
			
		else:
			for item in bodies_armazen:
				if valor_Player<=item.valor:
						return
				else:
					bodies_in_area[-1].global_position = global_position
					bodies_armazen.push_front(bodies_in_area[-1])
					valor_Player=0
					turnchage.colocouApeca = true
					
					
					
	
		
		#bodies_armazen.push_front(bodies_in_area[-1])
			#fazer_algo(pla)
	var overlapping_areas = get_overlapping_areas()
	
	#for area in overlapping_areas:
		#if area.pegou_peca == false:
			#ocupado = true
			#bodies_in_area.push_front(area)
		#print("Area",area)


	pass

func armazenar_fimTurno()->void:
	if turnchage.coldown== true:
		bodies_armazen = bodies_in_area.duplicate()
		bodies_in_area.clear()
		print("entrou aqui",bodies_armazen[-1])
	pass

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Boneco"):
		#fazer_algo(body)
		var index = bodies_in_area.find(body)
		bodies_in_area.remove_at(index)
		pecaEmCima= false
	pass # Replace with function body.


func _on_button_button_up() -> void:
	#qualturno = turnchage.get_turn()
	#
	
	pass # Replace with function body.
