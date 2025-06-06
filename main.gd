#extends Node
#
#const largura_grid = 3
#const altura_grid = 3
#
#var matriz_jogo = []
#
#func _ready():
	#criar_matriz_jogo()
#
	#for espaco in get_tree().get_nodes_in_group("espacos"):
		#espaco.connect("jogada_feita", Callable(self, "registrar_jogada"))
#
#func criar_matriz_jogo():
	#matriz_jogo = []
	#for x in range(largura_grid):
		#var linha = []
		#for y in range(altura_grid):
			#linha.append(0)
		#matriz_jogo.append(linha)
#
#func registrar_jogada(x: int, y: int, jogador: int, valor: int) -> void:
	#print("Jogada recebida:", x, y, "Jogador:", jogador, "Valor:", valor)
#
	#if matriz_jogo[x][y] != 0:
		#print("Espaço já ocupado!")
		#return
#
	#matriz_jogo[x][y] = jogador
#
	#print("Estado atual da matriz:")
	#for linha in matriz_jogo:
		#print(linha)


# Verifica linhas, colunas e diagonais
#func verificar_vencedor():
	## Linhas
	#for y in range(3):
		#if linha_completa(y):
			#return matriz_logica[y][0]["jogador"]
	## Colunas
	#for x in range(3):
		#if coluna_completa(x):
			#return matriz_logica[0][x]["jogador"]
	## Diagonal principal
	#if diagonal_principal_completa():
		#return matriz_logica[0][0]["jogador"]
	## Diagonal secundária
	#if diagonal_secundaria_completa():
		#return matriz_logica[0][2]["jogador"]
#
	#return null
#
#func linha_completa(y: int) -> bool:
	#var primeiro = matriz_logica[y][0]
	#if primeiro == null:
		#return false
	#for x in range(1, 3):
		#if matriz_logica[y][x] == null or matriz_logica[y][x]["jogador"] != primeiro["jogador"]:
			#return false
	#return true
#
#func coluna_completa(x: int) -> bool:
	#var primeiro = matriz_logica[0][x]
	#if primeiro == null:
		#return false
	#for y in range(1, 3):
		#if matriz_logica[y][x] == null or matriz_logica[y][x]["jogador"] != primeiro["jogador"]:
			#return false
	#return true
#
#func diagonal_principal_completa() -> bool:
	#var primeiro = matriz_logica[0][0]
	#if primeiro == null:
		#return false
	#for i in range(1, 3):
		#if matriz_logica[i][i] == null or matriz_logica[i][i]["jogador"] != primeiro["jogador"]:
			#return false
	#return true
#
#func diagonal_secundaria_completa() -> bool:
	#var primeiro = matriz_logica[0][2]
	#if primeiro == null:
		#return false
	#for i in range(1, 3):
		#if matriz_logica[i][2 - i] == null or matriz_logica[i][2 - i]["jogador"] != primeiro["jogador"]:
			#return false
	#return true

extends Node
class_name  Main
var turn:int = 0

var grab:bool =false

var todosBonecos = []
var todosPlayer2= []
var todosEspaços = [] 
var Tabuleiro = preload("res://TabuleiroIA.gd")
var jogo = Tabuleiro.new()
var matriz_espacos: Array = []
var matriz_logica: Array = []     
var nâoPodeMexer:bool = false
const TAMANHO_TABULEIRO = 3
var trocarTurno

var colocouApeca:bool = false
var segundos:float
var finalizarTurno:bool = false
var bonecos_filtrados:Array = [CharacterBody2D] 
var espacos_filtrados:Array = [[Node2D]] 
var players2_Armazenados: Array=[CharacterBody2D]
var coldown:bool =false
@onready var timer:Timer = $ContagemTimer
@onready var label_vencedor = $LabelVencedor
#var dadosBonecos
#var dadosEspacos
# Called when the node enters the scene tree for the first time.

	
func _ready() -> void:

	#
	#todosEspaços =get_tree().get_nodes_in_group("Espaco")
#
	#for espaco in todosEspaços:
		#if espaco is Area2D:
			#espacos_filtrados.push_front(espaco)
			#print("espaco: ", espaco.position) 
	#var colunas := 3
	#var linhas := 3
	#for linha_idx in range(linhas):
		#var linha: Array = []
		#for coluna_idx in range(colunas):
			#var index = linha_idx * colunas + coluna_idx
			#if index < espacos_filtrados.size():
				#linha.append(espacos_filtrados[index])
		#matriz_espacos.append(linha)
#
	## Exibir o conteúdo da matriz
	#for y in range(matriz_espacos.size()):
		#for x in range(matriz_espacos[y].size()):
			#var espaco = matriz_espacos[y][x]
			#print("Espaço [", y, "][", x, "] = ", espaco.name, " | Pos: ", espaco.position)
	var todos_espacos = get_tree().get_nodes_in_group("Espaco")
	var espacos_ordenados := todos_espacos.filter(func(n): return n is Area2D)

# Ordenar com base no nome: area_0_0, area_0_1, ...
	


	# Ordenar com base no nome: area_0_0, area_0_1, ...
	espacos_ordenados.sort_custom(func(a, b):
		var a_partes = a.name.split("_")
		var b_partes = b.name.split("_")
		
		var a_linha = int(a_partes[1])
		var a_coluna = int(a_partes[2])
		
		var b_linha = int(b_partes[1])
		var b_coluna = int(b_partes[2])

		if a_linha == b_linha:
			return a_coluna < b_coluna
		else:
			return a_linha < b_linha
	)

	# Montar matriz
	matriz_espacos.clear()
	matriz_logica.clear()

	for y in range(TAMANHO_TABULEIRO):
		var linha_visual := []
		var linha_logica := []
		for x in range(TAMANHO_TABULEIRO):
			var idx = y * TAMANHO_TABULEIRO + x
			linha_visual.append(espacos_ordenados[idx])
			linha_logica.append([])
		matriz_espacos.append(linha_visual)
		matriz_logica.append(linha_logica)
		
	
	
#
	print(matriz_espacos)
func achar_coordenadas_espaco(espaco: Node2D) -> Vector2:
	for y in range(TAMANHO_TABULEIRO):
		for x in range(TAMANHO_TABULEIRO):
		
			if matriz_espacos[y][x] == espaco:
					return Vector2(x, y)
					
	return Vector2(-1, -1) # Se não achar
	#print("Inimigos encontrados: ", todosBonecos.size())
#func colocar_peca(x: float, y: float, peca):
	#
	#matriz_logica[y][x].append(peca)
	#var pos = matriz_espacos[y][x].position
	#peca.position = pos
	#add_child(peca)
	#
	#
#
	## DEBUG: mostrar estado da matriz depois de colocar peça
	#for i in range(TAMANHO_TABULEIRO):
		#var linha = []
		#for j in range(TAMANHO_TABULEIRO):
			#if matriz_logica[i][j].size() > 0:
				#linha.append(str(matriz_logica[i][j][-1].boneco))
			#else:
				#linha.append("-")
		#print("Linha %d: %s" % [i, linha])
		#

#func pode_colocar(x: int, y: int, peca) -> bool:
	## Aqui você coloca a lógica para validar se pode colocar a peça na posição (x, y).
	## Exemplo simples: não deixar colocar se já tiver alguma peça no topo da pilha
	#if matriz_logica[y][x].size() > 0:
		#return false
	#return true

	
func verificar_vencedor(matriz_logica):
	var linhas = [
		[[0,0],[0,1],[0,2]], [[1,0],[1,1],[1,2]], [[2,0],[2,1],[2,2]], # linhas
		[[0,0],[1,0],[2,0]], [[0,1],[1,1],[2,1]], [[0,2],[1,2],[2,2]], # colunas
		[[0,0],[1,1],[2,2]], [[0,2],[1,1],[2,0]]                      # diagonais
	]

	for linha in linhas:
		var jogador_base = null
		var todos_iguais = true
		for pos in linha:
			var pilha = matriz_logica[pos[0]][pos[1]]  # y, x — CORRIGIDO AQUI!
			if pilha.size() == 0:
				todos_iguais = false
				break
			var topo = pilha[-1]
			if jogador_base == null:
				jogador_base = topo.time  # ou .time, mas mantenha consistente
			elif topo.time != jogador_base:
				todos_iguais = false
				break
		if todos_iguais and jogador_base != null:
			return jogador_base
	return null

	
	#for boneco in bonecos.get_children():
	#	if boneco.has_method("get"):
	#		dadosBonecos = {
	#			"valor": boneco.valor,
	#			"Jogador":boneco.time,
	#			"Nome":boneco.namePlay
	#		}
#
#			todosBonecos.append(dadosBonecos)		
	
	todosBonecos =get_tree().get_nodes_in_group("Player1")
	
#	pass # Replace with function body.
	for boneco in todosBonecos:
		if boneco is Node2D:
			
			bonecos_filtrados.push_front(boneco) 
			print("Inimigo: ", boneco.name)
			print("  Posição: ", boneco.global_position)
			print("  Valor: ", boneco.valor)
			print("  Time: ", boneco.time)
			
	todosPlayer2 = get_tree().get_nodes_in_group("Player2")
	
	for player2 in todosPlayer2:
		if player2 is CharacterBody2D:
		
			players2_Armazenados.push_front(player2)
			print("Inimigo: ", player2.name)
			print("  Posição: ", player2.global_position)
			print("  Valor: ", player2.valor)
			print("  Time: ", player2.valor)
			

	
func atualizar() -> void:
	for y in matriz_espacos.size():
		for x in matriz_espacos[y].size():
			if matriz_espacos[y][x] == TurnChange.ultimoEspaco:
				var peca = TurnChange.ultimaPeca  # ou TurnChange.ultimoValor
				if pode_colocar_peca(peca.valor, y, x):
					matriz_logica[y][x].append(peca)
					
					print("Peça colocada na posição [", y, ",", x, "]:", peca)
				else:
					print("Jogada inválida! Valor menor ou igual ao topo da pilha.")
					
func pode_colocar_peca(valor: int, y: int, x: int) -> bool:
	var pilha = matriz_logica[y][x]
	if pilha.is_empty():
		return true
	var topo = pilha[-1]
	return valor > topo.valor  # topo deve ser um boneco com atributo `valor`
func _process(delta: float) -> void:
	if TurnChange.turn == 0:
		label_vencedor.text = "Vez do Jogador Azul"
	elif TurnChange.turn ==1:
		label_vencedor.text = "Vez do Jogador Laranja"
		

	if TurnChange.registrar == true:
		atualizar()
		TurnChange.registrar = false
		TurnChange._trocarTurno()
		verificar_vencedor(matriz_logica)
		var vencedor = verificar_vencedor(matriz_logica)
		if vencedor != null:
			print("Jogador vencedor: ", vencedor)
			if(vencedor == 0):
				label_vencedor.text ="Jogador Azul Venceu"
			else:
				label_vencedor.text ="Jogador Laranja Venceu"
				
			
		
	
		#var coords = achar_coordenadas_espaco(TurnChange.ultimoEspaco)
		#if coords.x >= 0 and coords.y >= 0:
		#colocar_peca(round(TurnChange.especo_x), round(TurnChange.espaco_y), TurnChange.ultimaPeca)
		#TurnChange.registrar = false

	#var resultado = verificar_vencedor(matriz_logica)
	#if resultado != null:
		#var msg = "Jogador %d venceu com a peça de valor %d" % [resultado.jogador, resultado.valor]
		#print(msg)
		#label_vencedor.text = msg
	#else:
		#label_vencedor.text = "Ninguém venceu ainda"
##@export var scriptBoneco = preload("res://boneco.gd")
##var todosBonecos = []
##var todosEspaços = [[]]
##
### Called when the node enters the scene tree for the first time.
##func _ready() -> void:
	##
	##var armanezamento_Bonecos = get_node("Bonecos") 
##
	##for boneco in armanezamento_Bonecos.get_children():
		##if boneco.has_method("get"):
			##var dados ={
				##"valor": boneco.valor,
				##"Jogador":boneco.time
				##
			##}
##
			##todosBonecos.append(dados)			
	#
## Called every frame. 'delta' is the elapsed time since the previous frame.

	


func _on_button_button_up() -> void:
	TurnChange.finalizarTurno = false
	coldown = false
	pass # Replace with function body.


func _on_contagem_timer_timeout() -> void:
	pass # Replace with function body.
