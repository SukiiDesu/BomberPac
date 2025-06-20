.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo

.text
CONFIGURA_FASE_1:
##########################################################
# Renderiza os frames estaticamente (por completo) #######
##########################################################
	.include "RENDERIZA_FRAME_0_FASE_1.s"
	.include "RENDERIZA_FRAME_1_FASE_1.s"

################################################
###### Inicializa todos os scores ##############
################################################

	# Inicializa SCORE_TIMER
	la t0, SCORE_TIMER
	li t1, 60
	sw t1, 0(t0)

	# Inicializa VIDAS
	la t0, VIDAS
	li t1, 3
	sw t1, 0(t0)

	# Inicializa PONTOS
	la t0, PONTOS
	li t1, 0
	sw t1, 0(t0)

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
	sw a0, 0(s2)	# Inicializa: TEMPO_INICIA_TESTE = TEMPO_ATUAL	



INICIO_GAME_LOOP_FASE_1:

	.include "REDUZ_TIMER.s"

	.include "TECLADO_FASE_1.s"

	j INICIO_GAME_LOOP_FASE_1

FIM_GAME_LOOP_FASE_1:

#CONFIGURA_FASE_2:
#INICIO_GAME_LOOP_FASE_2:

#FIM_GAME_LOOP_FASE_2:
