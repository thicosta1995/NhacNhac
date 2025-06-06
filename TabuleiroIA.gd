extends Resource
class_name Tabuleiro

var Main = preload("res://main.gd")

const JOGADOR_X = "X"
const JOGADOR_O = "O"

@export var tabuleiro: Array
@export var jogador: String

func _init():
	self.tabuleiro = [
		[[], [], []],
		[[], [], []],
		[[], [], []],
	]
	self.jogador = JOGADOR_X

func alternar_jogador() -> void:
	self.jogador = JOGADOR_X if self.jogador == JOGADOR_O else JOGADOR_O

func empate() -> bool:
	return false
	'''
	deve ser removida, pois não há empate no nhac-nhac
	'''

func jogador_atual() -> String:
	return jogador

func movimentar(casa_origem: Vector2, casa_destino: Vector2, peca_jogador: int=0) -> Tabuleiro:
	if peca_jogador == 0:
		if TurnChange.jogadorPegPeca == true:
			print("movimentando peca  ",TurnChange.pecaEscolhida.name)
		
		elif	 TurnChange.jogadorPegPeca == false and TurnChange.colocouApeca == false:
			print("movimento peca  invalida ")	
			
			
		# move uma peça pelo tabuleiro
		pass
	else:
		if TurnChange.colocouApeca == true:
			var  lin:float
			var col:float# Coloca uma peça no tabuleiro
			lin = TurnChange.PosLargouApeca.x
			col = TurnChange.PosLargouApeca.y
			var novo_tabuleiro = self.duplicate(true)
			novo_tabuleiro.tabuleiro[lin][col] = jogador
			return novo_tabuleiro
		pass
		
	if casa_origem.x == INF or casa_origem.y == INF:
		# Coloca uma peça no tabuleiro
		pass
	elif peca_jogador == 0:
		# move uma peça pelo tabuleiro
		pass
		
	return null
	'''
	A função movimentar trata as duas mecanicas do jogo:
	(1) Colocar uma peça nova no tabuleiro
		movimentar(null, Vector2(2,1), -3)	
	(2) Mover uma peça de uma casa para outra
		movimentar(Vector2(0,0), Vector2(2,2))
	'''

func velha_movimentar(movimento: Vector2, jogador: String) -> Tabuleiro:
	return null
	'''
	var lin = movimento.x
	var col = movimento.y
	
	var novo_tabuleiro = self.duplicate(true)
	novo_tabuleiro.tabuleiro[lin][col] = jogador
	return novo_tabuleiro
	'''

func valida_jogada(casa: Vector2, peca: int) -> bool:
	return false
	'''
	if tabuleiro[casa.x][casa.y] == SEM_JOGADA:
		return true
	else:
		return false
	'''

func jogada(casa: Vector2, peca: int) -> bool:
	return false
	'''
	if valida_jogada(casa):
		tabuleiro[casa.x][casa.y] = jogador
		alternar_jogador()
		return true
	return false
	'''
	
func avaliar() -> float:
	return 0
	'''
	var eval: float = 0.5
	#print("Avaliando o tabuleiro: ", self.tabuleiro)
	for i in range(3):
		if self.tabuleiro[i][0] == self.tabuleiro[i][1] and self.tabuleiro[i][1] == self.tabuleiro[i][2] and self.tabuleiro[i][2] != SEM_JOGADA:
			eval = 1 if self.tabuleiro[i][0] == self.jogador else -1
			#print("Fim Jogo na linha: ", i, " o resultado foi: ", eval)
		if tabuleiro[0][i] == tabuleiro[1][i] and tabuleiro[1][i] == tabuleiro[2][i] and tabuleiro[2][i] != SEM_JOGADA:
			eval = 1 if self.tabuleiro[0][i] == self.jogador else -1
			#print("Fim Jogo na coluna: ", i, " o resultado foi: ", eval)
			
	if tabuleiro[0][0] == tabuleiro[1][1] and tabuleiro[1][1] == tabuleiro[2][2] and tabuleiro[2][2] != SEM_JOGADA:
		eval = 1 if tabuleiro[0][0] == self.jogador else -1
		#print("Fim Jogo na diagonal principal o resultado foi: ", eval)
	if tabuleiro[2][0] == tabuleiro[1][1] and tabuleiro[1][1] == tabuleiro[0][2] and tabuleiro[0][2] != SEM_JOGADA:
		eval = 1 if tabuleiro[2][0] == self.jogador else -1
		#print("Fim Jogo na diagonal secundaria o resultado foi: ", eval)
	return eval 
	'''


func jogadas_possiveis() -> Array:
	return [1, 2 , 3]
	'''
	var jogadas: Array = []
	for linha in range(3):
		for coluna in range(3):
			if tabuleiro[linha][coluna] == SEM_JOGADA:
				jogadas.append(Vector2(linha, coluna))
	return jogadas
	'''
	


	
