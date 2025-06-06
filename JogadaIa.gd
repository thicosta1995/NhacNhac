extends Resource
class_name Jogada

const INSERIR_PECA: int = 0
const MOVER_PECA: int = 1

var origem: Node2D
var destino: Node2D
var avaliacao: float
var tipo_jogada: int
var peca: int

func _init(destino: Vector2, peca: int, avaliacao: float):
	# Colocar peça nova
	self.origem.global_position = Vector2.INF
	self.destino.global_position = destino
	self.tipo_jogada = INSERIR_PECA
	self.peca = peca
	self.avaliacao = avaliacao
'''
func _init(origem: Vector2, destino: Vector2, avaliacao: float):
	# Colocar peça nova
	self.origem = Vector2.INF
	self.destino = destino
	self.tipo_jogada = INSERIR_PECA
	self.peca = peca
	self.avaliacao = avaliacao	
'''	
