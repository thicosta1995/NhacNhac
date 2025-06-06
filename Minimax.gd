extends Node
var jogada = preload("res://JogadaIa.gd")
var tabuleiro = preload("res://TabuleiroIA.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _melhorJogada(abuleiro: Tabuleiro, jogador: String, profundidade_maxima: int)-> Jogada:
		var jogada: Jogada = minimax(tabuleiro, jogador, profundidade_maxima, 0)
		print()
		return jogada
func minimax(tabuleiro:Tabuleiro,jogador:String,profundidade_maxima: int, profundidade: int)->Jogada:
	var avaliaca	o: float = tabuleiro.avaliar()
	var melhores_jogadas: Array = []
	var melhor_pontuacao: float
	if tabuleiro.jogador_atual() == jogador:
		melhor_pontuacao =-INF
	else:
		melhor_pontuacao =INF
		
	for movimento in tabuleiro.jogadas_possiveis():
		var novo_tabuleiro: Tabuleiro = tabuleiro.movimentar(movimento, jogador)
		var novo_jog: String = tabuleiro.JOGADOR_X if jogador == tabuleiro.JOGADOR_O else tabuleiro.JOGADOR_O
		var jogada: Jogada = minimax(novo_tabuleiro, novo_jog, profundidade_maxima, profundidade + 1)
		jogada.movimento = movimento
		if profundidade == 0:
			print("JOGADA: ", jogada.movimento, " Avaliacao: ", jogada.avaliacao)
			
		if tabuleiro.jogador_atual() == jogador:
			if jogada.avaliacao > melhor_pontuacao:
				melhor_pontuacao = jogada.avaliacao
				melhores_jogadas = []
				melhores_jogadas.append(jogada)
			elif jogada.avaliacao == melhor_pontuacao:
				melhores_jogadas.append(jogada)
		else:
			if jogada.avaliacao < melhor_pontuacao:
				melhor_pontuacao = jogada.avaliacao
				melhores_jogadas = []
				melhores_jogadas.append(jogada)
			elif jogada.avaliacao == melhor_pontuacao:
				melhores_jogadas.append(jogada)
	melhores_jogadas.shuffle()
	return melhores_jogadas[0]
