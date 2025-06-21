.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo

.text
CONFIGURA_FASE_1:
##########################################################
# Renderiza os frames estaticamente (por completo) #######
##########################################################
	#.include "RENDERIZA_FRAME_0_FASE_1.s"
	#.include "RENDERIZA_FRAME_1_FASE_1.s"

################################################
###### Inicializa todos os scores ##############
################################################
	#.include "INICIALIZA_SCORES.s"

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
	#la s2, TEMPO_INICIAL_SCORE_TIMER
	#sw a0, 0(s2)	# Inicializa: TEMPO_INICIAL_SCORE_TIMER = TEMPO_ATUAL	

	# Inicializa TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA
	sw a0, 0(s2)	# Inicializa: TEMPO_INICIAL_MUSICA = TEMPO_ATUAL		

######################
# Teste
######################

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

	#.include "REDUZ_TIMER.s"

	#.include "TECLADO_FASE_1.s"

	# Pega tempo em TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA	# Pega endereco de TEMPO_INICIAL_MUSICA
	lw s2, 0(s2)                    # Pega o conteudo de TEMPO_INICIAL_MUSICA

	# Pega tempo atual
	li a7, 30           # Chama a funcao TIME()
	ecall               # Chama o Sistema operacional

	# Pega o tempo passado desde o tempo inicial
	sub t3, a0, s2			# t3 = TEMPO_ATUAL - TEMPO_INICIAL_TESTE

	la t0, INDICE_NOTA	# t0 = &INDICE_NOTA
	lw t0, 0(t0)		# t0 = conteudo INDICE_NOTA
	li t1, 8			# 8 bytes corresponde a uma Nota
	mul t0, t0, t1		# t0 * 8 == numero de bytes a serem pulados ateh a nota atual

	la t4, NOTAS_MUSICA_FUNDO_FASE_1	# Pega endereco de NOTAS_MUSICA_FUNDO_FASE_1
	add t4, t4, t0						# t4 = Endereco da nota atual
	lw t2, 4(t4)						# t2 = Duracao da nota atual

	blt t3, t2, PULA_TOCA_PROXIMA_NOTA # Se passou mais tempo que a duracao da nota, "TOCA_PROXIMA_NOTA"

	# TOCA_PROXIMA_NOTA
	# Atualiza valores no "reprodutor de som"
	addi t4, t4, 8		# t4 = Endereco proxima nota
	lw a0, 0(t4)		# a0 = valor da proxima nota
	lw a1, 4(t4)		# a1 = duracao da proxima nota

	# Toca nota
	li a7, 31			# Configura sistema para tocar a nota midi escolhida acima
	ecall				# Chama o sistema operacional

	# Atualiza TEMPO_INICIAL_MUSICA
	li a7, 30   # Chama a funcao TIME()
	ecall       # Chama o Sistema operacional
	
	la s2, TEMPO_INICIAL_MUSICA    		# Pega endereco de TEMPO_INICIAL_MUSICA
	sw a0, 0(s2)                        # Atualiza o conteudo de TEMPO_INICIAL_MUSICA

	# Atualiza variaveis relacionadas a nota
	la t0, INDICE_NOTA					# t0 = &INDICE_NOTA
	lw t1, 0(t0)						# t1 = conteudo INDICE_NOTA
	addi t1, t1, 1						# t1++	: Passa para a proxima nota

	# Permite loop musical
	la t2, TAMANHO_MUSICA				# Pega endereco do TAMANHO_MUSICA
	lw t2, 0(t2)						# Pega conteudo do TAMANHO_MUSICA
	rem t1, t1, t2						# t1 = t1 % t2 : INDICE_NOTA = INDICE_NOTA % TAMANHO_MUSICA : Gera o loop musical
	sw t1, 0(t0)						# INDICE_NOTA = t1
	bnez t1, INICIO_GAME_LOOP_FASE_1	# Se INDICE_NOTA

# Ao tentar garantir que a primeira nota fosse tocada no loop 0, criei uma "nota falsa" (0, 0) na posicao 0
# Ou seja, a musica de verdade soh existe da posicoes 1 em diante.
# Por isso eh precisa a correcao abaixo
	#addi t1, t1, 1		# Pula a nota inexistente
	#sw t1, 0(t0)		# INDICE_NOTA = t1

PULA_TOCA_PROXIMA_NOTA:
	j INICIO_GAME_LOOP_FASE_1

FIM_GAME_LOOP_FASE_1:

#CONFIGURA_FASE_2:
#INICIO_GAME_LOOP_FASE_2:

#FIM_GAME_LOOP_FASE_2:
