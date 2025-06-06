extends CharacterBody2D
class_name  boneco

@export var valor: float 
var move: bool = false
var current_area: Area2D = null
var enter: bool = false
var pegou_peca: bool =false
var jaColocouApeça = false
var namePlay: String
var ocupado:bool = false
var podemexer:bool = true
var dropouPeca:bool =false
var colocandoPeca:bool = false
var guardado:bool= false 
var pos:Vector2

@export var time: int =0
@export var hovering_drop_slots : Array[Node2D] = []
@export var initial_position : Vector2
@export var armazen_de_espaco: Array[Node2D]=[]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#scale.y = scale.y * valor/1.5
	#scale.x = scale.x *valor/3
	namePlay = name
	if TurnChange.turn ==1 and time ==0:
		podemexer = false
	elif TurnChange.turn ==1 and time ==1:
		podemexer = true
	elif TurnChange.turn ==0 and time ==0:
		podemexer = true
	elif TurnChange.turn == 0 and time == 1:
		podemexer = false
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TurnChange.turn ==1 and time ==0 and ocupado ==false:
		podemexer = false
	elif TurnChange.turn ==1 and time ==1 and ocupado ==false:
		podemexer = true
	elif TurnChange.turn ==0 and time ==0 and ocupado ==false:
		podemexer = true
	elif TurnChange.turn == 0 and time == 1 and ocupado ==false:
		podemexer = false
	if TurnChange.coldown == true:
		podemexer = false
	if is_in_group("Player1"):
		time = 0
	elif is_in_group("Player2"):
		time = 1
	var turnchage = TurnChange
	var _turnPlayer = TurnChange.turn
	pos =position

	var mousepos = get_global_mouse_position()
	if move:
		position = mousepos
	if Input.is_action_just_pressed("Click") and enter == true and pegou_peca == false and time == _turnPlayer and TurnChange.grab == false and podemexer == true:
		
		move = true
		pegou_peca = true
		TurnChange.grab = true
		
		TurnChange.jogadorPegPeca = true
		TurnChange.pecaEscolhida = self
		TurnChange.PosPecaSegurado= self.global_position

	
	elif Input.is_action_just_released("Click") and enter == true and pegou_peca == true and time == _turnPlayer and TurnChange.grab == true and podemexer == true:
		
		move = false
		pegou_peca = false
		TurnChange.grab = false
		TurnChange.jogadorPegPeca = false
		if TurnChange.colocouApeca == false and colocandoPeca == true:
			self.global_position = TurnChange.PosPecaSegurado
		







func _on_area_2d_mouse_entered() -> void:
	enter = true
	
	


func _on_area_2d_mouse_exited() -> void:
	if move ==false:
		enter = false


func _on_area_2d_area_entered(area:Area2D) -> void:
	
	if area.is_in_group("Espaco"):
		hovering_drop_slots.push_back(area)

		colocandoPeca = true
		print("testando")
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Espaco"):
		var index = hovering_drop_slots.find(body)
		hovering_drop_slots.remove_at(index)

	pass # Replace with function body.


func _on_area_2d_body_entered(body:Node2D) -> void:
	print(body)
	if body.is_in_group("Espaco"):
		hovering_drop_slots.push_back(body)

		colocandoPeca = true
		print("testando")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Espaco"):
		var index = hovering_drop_slots.find(area)
		if index != -1:
			hovering_drop_slots.remove_at(index)

	pass # Replace with function body.

	
