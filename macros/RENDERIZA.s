########################################################
#                     MACROS
########################################################
.macro Preenche_Frame
	li t0,ENDERECO_INICIAL_FRAME_0
	li t5,0x11800
	add t5,t0,t5	# t5 = Endereco inicial da ultima matriz da linha
	
	li t6,0x130
	add t6,t0,t6	# t6 = Endereco inicial da ultima matriz do frame
	
	la t2, VERDE_WORD
LOOP_FRAME:
	bgt t0,t6,FIM_RENDERIZA
LOOP_LINHA_FRAME:
	li t1,0		# linha = 0
LOOP_LINHA:
	li t4,16			# t4 = numero de linhas
	beq t1,t4,FIM_PREENCHE_MATRIZ	# Extrapolou a linha : linha == 16
	li t3,0				# coluna = 0
LOOP_COLUNA:
	li t4,16			# t4 = numero de colunas
	beq t3,t4,SOMA_LINHA		# Enquanto coluna < 16
	
	#PREENCHE_WORD	
	lw t4,0(t2)		# t4 = 4 pixels de cor da imagem com endereco guardado em t2
	sw t4,0(t0)		# 4 pixels a partir do Endereco atual do frame mudam de cor
	addi t0,t0,4		# Atualiza Endereco atual do frame em 4 bytes
	#addi t2,t2,4		# Atualiza Endereco atual da imagem em 4 bytes
	
	#PREENCHE_BYTE
	#lb t4,0(t2)		# t4 = 1 pixel cor
	#sb t4,0(t0)		# 4 pixels a partir do Endereco atual do frame mudam de cor
	#addi t0,t0,1		# Atualiza Endereco atual do frame em 1 byte
	#addi t2,t2,1		# Atualiza Endereco atual da imagem em 1 byte
	
	addi t3,t3,4		# coluna++
	j LOOP_COLUNA

SOMA_LINHA:
	addi t1,t1,1	# linha++
	#Ainda nao extrapolou a linha
	addi t0,t0,-16
	#sub %reg1,%reg1,s5
	addi t0,t0,320
	#add %reg1,%reg1,s6
	j LOOP_LINHA
	
FIM_PREENCHE_MATRIZ:
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

FIM_RENDERIZA:
.end_macro


# Preenche o campo e ignora a renderizacao de pilastras e fundos vazios
.macro Preenche_Campo
	li t0,0xFF002810	# Endereco inicial do Campo (18 x 12)
	li t5,0x10400		# "offset" para passagem de colunas no campo
	add t5,t0,t5		# t5 = Endereco inicial da ultima matriz da linha
	
	li t6,0x120		# "offset" para flag : (ultima coluna a renderizar no campo)
	add t6,t0,t6		# t6 = Endereco inicial da ultima matriz do frame
	
	la t2, VERDE_WORD
LOOP_CAMPO:
	bgt t0,t6,FIM_RENDERIZA_CAMPO
	
LOOP_LINHA_CAMPO:
	li t1,0		# linha = 0
LOOP_LINHA_CAMPO:
	li t4,16			# t4 = numero de linhas
	beq t1,t4,FIM_PREENCHE_MATRIZ	# Extrapolou a linha : linha == 16
	li t3,0				# coluna = 0
LOOP_COLUNA_CAMPO:
	li t4,16			# t4 = numero de colunas
	beq t3,t4,SOMA_LINHA		# Enquanto coluna < 16
	
	#PREENCHE_WORD	
	lw t4,0(t2)		# t4 = 4 pixels de cor da imagem com endereco guardado em t2
	sw t4,0(t0)		# 4 pixels a partir do Endereco atual do frame mudam de cor
	addi t0,t0,4		# Atualiza Endereco atual do frame em 4 bytes
	#addi t2,t2,4		# Atualiza Endereco atual da imagem em 4 bytes
	
	addi t3,t3,4		# coluna++
	j LOOP_COLUNA_CAMPO

SOMA_LINHA_CAMPO:
	addi t1,t1,1	# linha++
	#Ainda nao extrapolou a linha
	addi t0,t0,-16
	#sub %reg1,%reg1,s5
	addi t0,t0,320
	#add %reg1,%reg1,s6
	j LOOP_LINHA_CAMPO
	
FIM_PREENCHE_MATRIZ_CAMPO:
	mul s0,s0,s1
	bgt t0,t5,PROXIMA_COLUNA_CAMPO
	j LOOP_LINHA_CAMPO

PROXIMA_COLUNA_CAMPO:
	# Corrige posicao do endereco da proxima matriz
	li t1,61440	# t1 = Total de pixels da posicao atual ate a primeira linha do frame
	sub t0,t0,t1	# Volte para o inicio da coluna que estamos
	li t1,16	# t1 = colunas entre uma matriz e outra
	add t0,t0,t1	# Va para a proxima matriz
	
	li t5,0x11800
	add t5,t0,t5	# t5 = Endereco inicial da ultima matriz da coluna
	j LOOP_CAMPO

FIM_RENDERIZA_CAMPO:
.end_macro

######################################################################################################################################################
##########################################                    RENDERIZACAO POR TILEMAP                      ##########################################
######################################################################################################################################################

#---------------------------------------------------------#
#          Consideracaoes para Preenche_Frame             |
#---------------------------------------------------------#
	## LOOP funciona na mesma logica de C. A verificacao do encerramento do loop so ocorre em Inicio: LOOP ##
	## Frame eh a matriz do Bitmap Display ##
	## Tilemap eh a matriz do "mapa.data" ##
	## "Proxima posicao no Tilemap" eh dada pela Funcao: Proxima_Posicao_Tilemap ##
	## "Proxima posicao no Frame" eh dada pela Funcao: Proxima_Posicao_Frame ##

####################################################################################
################### Renderiza Frame (Todo o Bitmap Display) ########################
####################################################################################
#Inicio: Funcao Preenche_Frame
#	R0{} = POSICAO_INICIAL_TILEMAP		## R0{} sera a posicao atual no Tilemap ##
#	S1{} = FLAG				## S1{} sera a condicao de parada do loop ##
#	S0{} = POSICAO_INICIAL_FRAME		## S0{} sera a posicao atual no Frame ##
#	Inicio: LOOP_Percorre_Tilemap:
#		R1{} = CONTEUDO EM 0(R0{})
#		switch R1{}:				## Igual no C : Se R1{} == case, execute o codigo do case ##
#			case n;
#				R1{} = POSICAO_INICIAL_SPRITE_n
#				Pula para funcao Renderiza_Matriz
#
#		Inicio: Funcao Renderiza_Matriz_16x16(S0{}, R1{})
#		Fim: Funcao Renderiza_Matriz_16x16(S0{}, R1{})
#
#		Inicio: Funcao Atualiza_Posicoes
#			R0{} = "Proxima posicao no Tilemap"
#			S0{} = "Proxima posicao no Frame"
#		Fim: Funcao Atualiza_Posicoes
#	Fim: LOOP_Percorre_Tilemap:
#Fim: Funcao Preenche_Frame


#---------------------------------------------------------#
#          Consideracaoes para Preenche_Campo             |
#---------------------------------------------------------#
	## LOOP funciona na mesma logica de C. A verificacao do encerramento do loop so ocorre em Inicio: LOOP ##
	## Tilemap Campo eh uma matriz maenor inserida em Tilemap ##
	## Campo eh uma matriz menor inserida em Frame ##
	## "Proxima posicao no Tilemap Campo" eh dada pela Funcao: Proxima_Posicao_Tilemap_Campo ##
	## "Proxima posicao no Campo" eh dada pela Funcao: Proxima_Posicao_Campo ##
	
####################################################################################
################### Renderiza somente o Campo (Espaco jogavel) #####################
####################################################################################
#Inicio: Funcao Preenche_Campo
#	R0{} = POSICAO_INICIAL_TILEMAP_CAMPO		## R0{} sera a posicao atual no Tilemap Campo ##
#	S1{} = FLAG					## S1{} sera a condicao de parada do loop ##
#	S0{} = POSICAO_INICIAL_CAMPO			## S0{} sera a posicao atual no Campo ##
#	Inicio: LOOP_Percorre_Tilemap_Campo:
#		R1{} = CONTEUDO EM 0(R0{})
#		switch R1{}:				## Igual no C : Se R1{} == case, execute o codigo do case ##
#			case 1:
#				Pula para funcao Atualiza_Posicoes	## Ignore os quadrados 1 porque sao blocos indestrutiveis (pilastras) ##
#			...
#			case n;
#				R1{} = POSICAO_INICIAL_SPRITE_n
#				Pula para funcao Renderiza_Matriz
#
#		Inicio: Funcao Renderiza_Matriz_16x16(S0{}, R1{})
#		Fim: Funcao Renderiza_Matriz_16x16(S0{}, R1{})
#
#		Inicio: Funcao Atualiza_Posicoes
#			R0{} = "Proxima posicao no Tilemap Campo"
#			S0{} = "Proxima posicao no Campo"
#		Fim: Funcao Atualiza_Posicoes
#	Fim: LOOP_Percorre_Tilemap_Campo:
#Fim: Funcao Preenche_Campo
