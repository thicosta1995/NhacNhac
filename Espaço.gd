extends Area2D

@export var player: bool = true
var boneco = preload("res://area_boneco.tscn")
@export var qplayer: int
var valor_Player: int
var bodies_in_area: Array = []
var ocupado:bool = false
var pecaEmCima:bool= false
var positionTabuleiro:Vector2
var namePlay:String
var posPeca:Vector2
var turnchage = TurnChange

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

	


func _process(delta: float) -> void:
	if pecaEmCima == true:
		
		if turnchage.grab == false:
			var pla = bodies_in_area.pop_front()
	
			#fazer_algo(pla)
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		#if area.pegou_peca == false:
			#ocupado = true
			#bodies_in_area.push_front(area)
		print("Area",area)


	pass


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Boneco"):
		#fazer_algo(body)
		pecaEmCima= false
	pass # Replace with function body.
