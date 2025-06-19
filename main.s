.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo

.text
CONFIGURA_FASE_1:
	.include "RENDERIZA_FRAME_0_FASE_1.s"
	.include "RENDERIZA_FRAME_1_FASE_1.s"
	#j INICIO_FRAME_0_FASE_1
	
INICIO_GAME_LOOP_FASE_1:
	.include "TECLADO_FASE_1.s"
	j INICIO_GAME_LOOP_FASE_1
FIM_GAME_LOOP_FASE_1:


#CONFIGURA_FASE_2:
#INICIO_GAME_LOOP_FASE_2:

#FIM_GAME_LOOP_FASE_2:
