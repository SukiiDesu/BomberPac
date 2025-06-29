.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo
	DEBUG_MSG: .string "Achei um bloco de valor 2\n"

.text
################################################
###### Controle de Fases ######
################################################
	la t0, FASE_1
	la t1, TILEMAP_MUTAVEL
	sw t0, 0(t1)

    la t0, FASE_ATUAL
	li t1, 1
    sw t1, 0(t0)

	j CONFIGURA_FASE_1

PASSA_FASE_2:
	la t0, FASE_2
	la t1, TILEMAP_MUTAVEL
	sw t0, 0(t1)

	la t0, FASE_ATUAL
	li t1, 2
    sw t1, 0(t0)

CONFIGURA_FASE_1:
##########################################################
# Renderiza os frames estaticamente (por completo) #######
##########################################################
	.include "RENDERIZA_FRAME_0_FASE_1.s"
	.include "RENDERIZA_FRAME_1_FASE_1.s"
	.include "RENDERIZA_HUD.s"

################################################
###### Inicializa Frame a ser renderizado ######
################################################
	li t0, 0xFF200604	# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
	li t1, 0			# Pega o valor 0
	sw t1, 0(t0)		# O primeiro FRAME a ser mostrado serah o FRAME 0

################################################
###### Inicializa posicao Jogador ##############
################################################
	la t0, POSICAO_JOGADOR
	li t1, 41
	sw t1, 0(t0)
	
	la t1, IMAGEM_JOGADOR_baixo
	la t5, IMAGEM_JOGADOR
	sw t1, 0(t5)

	# # Inicializa ULTIMA_TECLA_LIDA
	# la s2, ULTIMA_TECLA_LIDA
	# li t0, 's'
	# sw t0, 0(s2)

	# # Inicializa TEMPO_INICIAL_POWER_UP_FORCA
	# la s2, TEMPO_INICIAL_POWER_UP_FORCA
	# li t0, -1
	# sw t0, 0(s2)	# Inicializa: TEMPO_INICIAL_MUSICA = TEMPO_ATUAL

################################################
###### Inicializa todos os scores ##############
################################################
	.include "INICIALIZA_SCORES.s"

##############################################################
# Inicializa todos os TEMPO_INICIAL das funcoes periodicas ###
##############################################################
	# Pega tempo atual
	li a7, 30
	ecall

	# Correcao para que todas funcoes rodem pela primeira vez
	li t0, -6000		# O valor aqui precisa ser ajustado para que todas as funcoes funcionem
	add a0, a0, t0		# "Atrasa" TEMPO_ATUAL
											
	# Inicializa TEMPO_INICIAL_SCORE_TIMER
	la s2, TEMPO_INICIAL_SCORE_TIMER
	sw a0, 0(s2)	# Inicializa: TEMPO_INICIAL_SCORE_TIMER = TEMPO_ATUAL			

	# Inicializa TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA
	li t0, 0
	sw t0, 0(s2)	# Inicializa: TEMPO_INICIAL_MUSICA = TEMPO_ATUAL

#############################################################
# Inicializa as variaveis de usadas na MUSICA ###
#############################################################

	# Configura instrumento
	li a2, 42	# Define que o timbre do instrumento : Nesse caso, um instrumento de cordas qualquer
	li a3, 80	# Define o volume da nota : Nesse caso 80 decibeis

	# Inicializa ponteiro ("agulha") da musica
	li t0, 0			# t0 = 0
	la t1, INDICE_NOTA	# t1 = &INDICE_NOTA
	sw t0, 0(t1)		# INDICE_NOTA = 0 : Comecamos a musica na nota 0

	# Inicializa TAMANHO_MUSICA : variavel auxiliar que guarda o numero de notas da musica. Serve para permitir loop de musica
	la t0, TAMANHO_MUSICA_FUNDO_FASE_1	# Pega endereco de TAMANHO_MUSICA_FUNDO_FASE_1
	lw t0, 0(t0)						# Pega conteudo de TAMANHO_MUSICA_FUNDO_FASE_1
	la t1, TAMANHO_MUSICA				# Pega endereco de TAMANHO_MUSICA
	sw t0, 0(t1)						# TAMANHO_MUSICA = TAMANHO_MUSICA_FUNDO_FASE_1

INICIO_GAME_LOOP_FASE_1:

	# li a7, 4
	# la a0, DEBUG_MSG
	# ecall
	.include "REDUZ_TIMER.s"

	##################################
	### Verifica Estado de PowerUp ###
	##################################

	# # Redundante, mas eh boa pratica
	# la t0, SCORE_TIMER      # Pega o endereco de SCORE_TIMER
	# lw t1, 0(t0)            # Pega o conteudo de SCORE_TIMER

	# la t0, TEMPO_INICIAL_POWER_UP_FORCA
	# lw t4, 0(t0)
	
	# sub t2, t1, t4
	# li t3, 6
	# bgt t2, 6, ENCERRA_EVENTO

	# la t6, ULTIMA_TECLA_LIDA
	# lw t6, 0(t6)

	# CASO_FORCA_CIMA:
	# 	li t2, 'w'						# Pegue o valor 0
	# 	bne t6, t2, CASO_FORCA_BAIXO	# Compare com o valor no byte atual do Tilemap

	# 	# Carrega sprite de forca
	# 	la t1, IMAGEM_JOGADOR_FORCA_cima	# pega o endereco de "IMAGEM_JOGADOR_FORCA_cima" e coloca em t1
	# 	la t5, IMAGEM_JOGADOR				# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
	# 	sw t1, 0(t5)						# coloca o endereco de t1 no endereco de t5 

	# 	j FIM_EVENTOS

	# CASO_FORCA_BAIXO:
	# 	li t2, 's'						# Pegue o valor 0
	# 	bne t6, t2, CASO_FORCA_DIREITA	# Compare com o valor no byte atual do Tilemap

	# 	# Carrega sprite de forca
	# 	la t1, IMAGEM_JOGADOR_FORCA_baixo	# pega o endereco de "IMAGEM_JOGADOR_FORCA_cima" e coloca em t1
	# 	la t5, IMAGEM_JOGADOR				# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
	# 	sw t1, 0(t5)						# coloca o endereco de t1 no endereco de t5 

	# 	j FIM_EVENTOS

	# CASO_FORCA_DIREITA:
	# 	li t2, 'd'						# Pegue o valor 0
	# 	bne t6, t2, CASO_FORCA_ESQUERDA	# Compare com o valor no byte atual do Tilemap

	# 	# Carrega sprite de forca
	# 	la t1, IMAGEM_JOGADOR_FORCA_direita	# pega o endereco de "IMAGEM_JOGADOR_FORCA_cima" e coloca em t1
	# 	la t5, IMAGEM_JOGADOR				# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
	# 	sw t1, 0(t5)						# coloca o endereco de t1 no endereco de t5 

	# 	j FIM_EVENTOS	

	# CASO_FORCA_ESQUERDA:
	# 	li t2, 'a'					# Pegue o valor 0
	# 	bne t6, t2, FIM_EVENTOS		# Compare com o valor no byte atual do Tilemap

	# 	# Carrega sprite de forca
	# 	la t1, IMAGEM_JOGADOR_FORCA_esquerda	# pega o endereco de "IMAGEM_JOGADOR_FORCA_cima" e coloca em t1
	# 	la t5, IMAGEM_JOGADOR					# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
	# 	sw t1, 0(t5)							# coloca o endereco de t1 no endereco de t5 

	# 	j FIM_EVENTOS	

	# ENCERRA_EVENTO:
	# # Encerra evento 
	# li t3, -1
	# sw t3, 0(t0)

	# FIM_EVENTOS:
	# ####################################
	# # RENDERIZAÇOES DINAMICAS #
	# ####################################

	.include "RENDERIZA_CAMPO.s"
	.include "RENDERIZA_JOGADOR.s"

	# Troca/Inverte Frames
	li t0, 0xFF200604	# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
	lw t1, 0(t0)		# Pega o valor 0
	xori t1, t1, 1		# Se Frame atual == 0, alterna para o frame 1 e vice-versa
	sw t1, 0(t0)		# Atualiza o valor de SELECAO_DE_FRAME_EXIBIDO
	
	.include "TECLADO_FASE_1.s"

	# ############################
	# # FUNCAO ATUALIZA_TILEMAP
	# ############################
	# A posicao do personagem eh salva como parte do Tilemap

	.include "ATUALIZA_TILEMAP.s"

	#.include "TOCA_MUSICA.s"

	j INICIO_GAME_LOOP_FASE_1

FIM_GAME_LOOP_FASE_1:
	li a7, 10
	ecall
