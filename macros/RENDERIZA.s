########################################################
#                     INCLUDES
########################################################

# Supostamente todos os frames da animacao podem estar um unico arquivo ".data". Verificar a veracidade

# Pilastra
	#.include ".\pilatra.data"		# Sprite pilastra

# Tijolo
	#.include ".\tijolo.data"		# Sprite tijolo

# Campo e Ponto
	#.include ".\campoComPonto.data"		# Sprite Campo com ponto

	# Sprite Campo sem ponto (grama verde) : Precisa?? : (Fazer um fundo personalizado (com graminhas) ao inves de verde chapado??)
	#.include ".\campoSemPonto.data"		

# Personagem
	#.include "..\imagens\personagemDireita.data"		# Movimento do personagem para a direita
	#.include "..\imagens\personagemEsquerda.data"		# Movimento do personagem para a esquerda
	#.include "..\imagens\personagemCima.data"			# Movimento do personagem para a cima
	#.include "..\imagens\personagemBaixo.data"			# Movimento do personagem para a baixo
	#.include "..\imagens\personagemDano.data"			# Quando o personagem toma dano -- Provavelvemente overkill
	#.include "..\imagens\personagemMorte.data"			# Morte do personagem
	#.include "..\imagens\personagemPowerUp.data"		# Animacao para power ativo : precisa ???

# Mob
	#.include "..\imagens\mobDireita.data"		# Movimento do mob para a direita
	#.include "..\imagens\mobEsquerda.data"		# Movimento do mob para a esquerda
	#.include "..\imagens\mobCima.data"			# Movimento do mob para a cima
	#.include "..\imagens\mobBaixo.data"		# Movimento do mob para a baixo
	#.include "..\imagens\mobMorte.data"		# Morte do mob

# Boss
	#.include "..\imagens\bossDireita.data"		# Movimento do boss para a direita
	#.include "..\imagens\bossEsquerda.data"	# Movimento do boss para a esquerda
	#.include "..\imagens\bossCima.data"		# Movimento do boss para a cima
	#.include "..\imagens\bossBaixo.data"		# Movimento do boss para a baixo
	#.include "..\imagens\bossMorte.data"		# Morte do boss

# Bomba
	#.include "..\imagens\bombaIdle.data"		# Bomba idle
	
# Explosao
	#.include "..\imagens\explosa.data"		# Animacao explosao

# Power Ups
	#.include "..\imagens\powerUp1.data"
	#...
	#.include "..\imagens\powerUpN.data"

# Armadilhas
	#.include "..\imagens\armadilha1.data"
	#...
	#.include "..\imagens\armadilhaN.data"

# Pontos 
# (E se os pontos fossem ferramentas ou algo diferente de bolinhas???? 
#- O intuito é disfarcar/esconder o fato de nao contabilizar o meio da matriz)
	#.include "..\imagens\campoComPonto.data"		# Bomba idle

########################################################
#                     MACROS
########################################################

# Atualiza as cores do frame e itera os enderecos do frame e da imagem
# %reg1 == Endereco atual do frame
# %reg2 == Endereco atual da imagem
.macro PREENCHE_WORD(%reg1, %reg2)
	lw t4,0(%reg2)		# t4 = Conteudo do Endereco atual da imagem
	sw t4,0(%reg1)		# 4 pixels a partir do Endereco atual do frame mudam de cor
	addi %reg1,%reg1,4	# Atualiza Endereco atual do frame em 4 bytes
	#addi %reg2,%reg2,4	# Atualiza Endereco atual da imagem em 4 bytes
.end_macro 

# Atualiza as cores do frame e itera os enderecos do frame e da imagem
# %reg1 == Endereco atual do frame
# %reg2 == Endereco atual da imagem
.macro PREENCHE_BYTE(%reg1,%reg2)
	#lb t4,0(%reg2)		# t4 = 1 pixel cor
	sb t4,0(%reg1)		# 4 pixels a partir do Endereco atual do frame mudam de cor
	addi %reg1,%reg1,1	# Atualiza Endereco atual do frame em 1 byte
	#addi %reg2,%reg2,1	# Atualiza Endereco atual da imagem em 1 byte
.end_macro

# Recebe o endereco mais a esquerda e acima da matriz : [0,0]
.macro PREENCHE_MATRIZ(%reg1, %reg2)
	li s5,16	# Tamanho de linhas e colunas
	li s6,320	# Pixels por linha
	
	li t1,0		# linha = 0
LOOP_LINHA:
	beq t1,s5,FIM_PREENCHE_MATRIZ	# Extrapolou a linha
	li t3,0				# coluna = 0
LOOP_COLUNA:
	beq t3,s5,SOMA_LINHA		# Enquanto coluna < 16
	PREENCHE_WORD(%reg1,%reg2)	
	#PREENCHE_BYTE(%reg1`,%reg2)
	addi t3,t3,4			# coluna++
	j LOOP_COLUNA

SOMA_LINHA:
	addi t1,t1,1	# linha++
	#Ainda nao extrapolou a linha
	sub %reg1,%reg1,s5
	add %reg1,%reg1,s6
	j LOOP_LINHA

FIM_PREENCHE_MATRIZ:
.end_macro 


.data
	.eqv ENDERECO_INICIAL_FRAME_0 0xFF000000
	.eqv ENDERECO_FIM_FRAME_0 0xFF012C00
	.eqv NUM_MAGICO_1 5440
	.eqv NUM_MAGICO_2 76160
	VERDE_WORD: .word 0x10101010
	VERDE_BYTE: .byte 0x10
	VERMELHO_WORD: .word 0x07070707
	VERMELHO_BYTE: .byte 0x07
.text
	li t0,ENDERECO_INICIAL_FRAME_0
	li t5,0x11800
	add t5,t0,t5	# t5 = Endereco inicial da ultima matriz da linha
	
	li t6,0x130
	add t6,t0,t6	# t6 = Endereco inicial da ultima matriz do frame
	
	la t2, VERDE_WORD
LOOP_FRAME:
	bgt t0,t6,EXIT
LOOP_LINHA_FRAME:
	PREENCHE_MATRIZ(t0,t2)
	mul s0,s0,s1
	bgt t0,t5,PROXIMA_COLUNA_FRAME
	j LOOP_LINHA_FRAME

PROXIMA_COLUNA_FRAME:
	# Corrige posicao do endereco da proxima matriz
	li t1,76800	# t1 = Total de pixels da posicao atual ate a primeira linha do frame
	sub t0,t0,t1	# Volte para o inicio da coluna que estamos
	li t1,16	# t1 = colunas entre uma matriz e outra
	add t0,t0,t1	# Va para a proxima matriz
	
	li t5,0x11800
	add t5,t0,t5	# t5 = Endereco inicial da ultima matriz da coluna
	j LOOP_FRAME

EXIT:
	#lw t2,VERMELHO_WORD
	#sw t2,0(t0)
	li a7,10
	ecall
# Renderiza usando TIME() como separador: recebe o endereco base em um reg1 e o tempo base em reg2
#.macro RENDERIZA_TIME(%reg1, %reg2)
#.end_macro

# Renderiza uma matriz do campo : reg1 = endereco atual do frame, reg2 = endereco da label inicial da matriz : Tente que testar
#.macro PRINTA_SPRITE(%reg1, %reg2)
	#mv t0,%reg1		# t0 = endereco atual do frame

	#li s5,0(%reg2)		# Comprimento da matriz
	#li s6,0(%reg2)		# Altura da matriz

	#li t1,0			# Linha_atual = 0
#LOOP_LINHA: beq t1,s5,FIM_MATRIZ
			#mul t2,t1,320		
			#add t2,t2,t1		# Pega linha atual
			#li t3,0			# Coluna_atual = 0
#LOOP_COLUNA: beq t3,s6,SOMA_LINHA
			#lw t4,0(%reg2)			# Pega 4 pixels (bytes) da imagem
			#sw t4,0(t0)			# Renderiza 4 pixels (bytes) no frame
			#addi %reg2, %reg2, 4	# Passa para os proximos 4 bytes na imagem
			#addi t0,t0,4			# Passa para os proximos 4 bytes no frame
			#addi t3, t3, 1 		# coluna++
			#j LOOP_COLUNA

#SOMA_LINHA:
	#addi t1, t1, 1 # linha++
	#j LOOP_LINHA
			

#FIM_MATRIZ:
#.end_macro
