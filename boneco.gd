extends CharacterBody2D
class_name  boneco

@export var valor: float 
var move: bool = false
var current_area: Area2D = null
var enter: bool = false
var pegou_peca: bool =false
var namePlay: String
var dropouPeca:bool =false
var colocandoPeca:bool = false
var pos:Vector2
@export var time: int =0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.y = scale.y * valor/1.5
	scale.x = scale.x *valor/3
	namePlay = name
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var turnchage = TurnChange
	var _turnPlayer = TurnChange.turn
	pos =position
	
	var mousepos = get_global_mouse_position()
	if move:
		position = mousepos
	if Input.is_action_just_pressed("Click") and enter == true and pegou_peca == false and time == _turnPlayer and turnchage.grab == false:
		move = true
		pegou_peca = true
		turnchage.grab = true

	
	elif Input.is_action_just_released("Click") and enter == true and pegou_peca == true and time == _turnPlayer and turnchage.grab == true:
		
		move = false
		pegou_peca = false
		turnchage.grab = false







func _on_area_2d_mouse_entered() -> void:
	enter = true
	
	


func _on_area_2d_mouse_exited() -> void:
	if move ==false:
		enter = false


func _on_area_2d_area_entered(area:Area2D) -> void:
	if area.is_in_group("Espacos"):
		colocandoPeca = true
		print("testando")
	
