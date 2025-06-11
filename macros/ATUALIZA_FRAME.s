########################################################
#                     MACROS
########################################################

# Recebe o frame atual e o alterna com o proximo: 0 -> 1 e 1 -> 0
#.macro ALTERNA_FRANES(%reg)		# Ajuda estah disponivel em Lab1\Exemplos\frames.s
#.end_macro

# Verifica se ocorre colisao entre a matriz iniciada em %reg e a iniciada em %reg1
#.macro VERIFICA_COLISAO(%reg, %reg1)
	# Fazer viloes e personagem com mesmo tamanho de matriz por conveniencia?????
#.end_macro

# Atualiza o endereco inicial do personagem x pixels na direcao desejada
#.macro ANDA_PERSONAGEM(%reg)
#.end_macro


########################################################
#           PERSONAGEM/MOB/BOSS VISUALIZER
########################################################

#    A-----------------------C
#    -------------------------
#    -------------------------
#    -----------s7------------
#    -------------------------
#    -------------------------
#    B-----------------------D

# s7 guarda o endereco do centro do pesonagem, A, B, C e D sao as quinas do personagem
# Da esquerda para a direita e de cima para baixo, temos respectivamente
# A = s7 - 320 * (metade_linhs_MATRIZ) - colunas_MATRIZ
# B = s7 + 320 * (metade_linhs_MATRIZ) - colunas_MATRIZ
# C = s7 - 320 * (metade_linhs_MATRIZ) + colunas_MATRIZ
# D = s7 + 320 * (metade_linhs_MATRIZ) + colunas_MATRIZ

# As quinas servem para verificar colisoes com os blocos do meio do campo

########################################################
#                CAMPO VISUALIZER
########################################################

#    1111111111111111111111111111111
#    1--00----------4----333----4--1
#    1-----1--2--1-----1-----1-----1
#    1--6-----------7------3----7--1
#    1-----1-----1-----1333331-----1
#    133333-33333---2-----5--------1
#    1111111111111111111111111111111

# A imagem nao corresponde a proporcao de pixels/matriz escolhida
# Tijolos sao definidos aleatoriamente
# Power ups e armadilhas aparecem ao quebrar blocos

# LEGENDA
# 0 - Campo Vazio
# 1 - Pilastra
# 2 - Campo com Ponto
# 3 - Tijolo
# 4 - Mob
# 5 - Boss
# 6 - Power Up
# 7 - Armadilha

########################################################
#                FRAME VISUALIZER
########################################################

#    ||LLL|||||||||PP|||||||||||||||
#    ||||||||||||||||||||TIME||TTT||
#    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
#    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
#    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
#    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
#    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

# A imagem nao corresponde a proporcao de pixels escolhida
# LEGENDA
# L - vidas
# P - Pontos
# T - Tempo em segundos
# C - Campo
# | - Fundo do Menu

# Os valores dos tres campos acima variam de a ate j
# a == 0, b == 1, c == 2, d == 3, e == 4, f == 5, g == 6, h == 7, i == 8, j == 9
# A ideia eh associar cada letra ao sprite do respectivo algarismo (exige algoritmo para "percorrer algarismos")

# Sei que pode ficar confuso representar numeros com letras, mas isso eh alteravel de acordo com a conveniencia/necessidade 

########################################################
#                     MAIN
########################################################

# Calcula a chance de dropar um Power Up ou uma Armadilha
# Chance Power Up:  % Chance Armadilha:  %
# Se "cair" Power Up altera o valor da matriz para 6
# Se "cair" Armaldilha altera o valor da matriz para 7
#.macro
#.end_macro

# .data		# .data eh obrigatorio??
# 
#.macro
	# ALTERNA_FRAME()
	#########
#.end_macro


# Renderiza usando TIME() como separador: recebe o endereco base em um reg1 e o tempo base em reg2
#.macro RENDERIZA_TIME(%reg1, %reg2)
#.end_macro



######################################################################################################################################################
##########################################                    MOVIMENTACAO POR TILEMAP                      ##########################################
######################################################################################################################################################

#---------------------------------------------------------#
#         Consideracaoes para Movimenta_Jogador           |
#---------------------------------------------------------#
	## O conteudo em R0{} foi adquirido pelo pooling do Teclado ##
	## A movimentacao eh desativada ao usar CAPS LOCK ##
	## A posicao do Jogador no Tilemap estah sempre salva no mesmo registrador ao longo do jogo - rJ{} ##
	## Offset eh um numero usado para "desviar" ou "corrigir" outro numero ##
	## A Funcao: Atualiza_Animacao estah na biblioteca "Animacao". Estah em planejamento ##
	## A Funcao: Configura_PowerUp estah na biblioteca "Configura". Estah em planejamento ##
	## A Funcao: Configura_Armadilha estah na biblioteca "Configura". Estah em planejamento ##	
	## A Funcao: Coloca Explosivo ainda estah por ser planejada ##
	## A Label PROXIMA_ETAPA estah no gameloop. Ela leva a Funcao: Proxima_Etapa que estah em planejamento ##
	## A Funcao: Coloca Explosivo ainda estah por ser planejada ##
	## A Funcao: Coloca Explosivo ainda estah por ser planejada ##
	#-----------------------------------------------------------------------------#
	##  Aplicacao da Funcao: Anda_Jogador:  ##
		#0(R1{}) = 0(rJ)	## Conteudo na posicao R1{} recebe o conteudo (valor) de Jogador : Jogador vai para o proximo quadrado do Tilemap ##
		#0(rJ) = 0		## Conteudo na posicao do Jogador se torna um espaco vazio ##	
		#rJ = R1		## Atualiza a posicao do Jogador ##
	#-----------------------------------------------------------------------------#	
####################################################################################
################### Computa a Movimentacao do Jogador ##############################
####################################################################################
#Inicio: Funcao Movimenta_Jogador
#	switch R0{}:				## Igual no C : Se R1{} == case, execute o codigo do case ##
#		case 'w':
#			R1{} = offset_cima
#			j ATUALIZA_POSICAO
#		case 'a':
#			R1{} = offset_esquerda
#			j ATUALIZA_POSICAO
#		case 's':
#			R1{} = offset_baixo
#			j ATUALIZA_POSICAO
#		case 'd':
#			R1{} = offset_direita
#			j ATUALIZA_POSICAO
#		case 'BARRA DE ESPACO':
#			Inicio: Funcao: Coloca_Explosivo
#			Fim: Funcao: Coloca_Explosivo
#			j FIM_MOVIMENTA_JOGADOR
#		case 'P':
#			j PROXIMA_ETAPA
#			j FIM_MOVIMENTA_JOGADOR
#		case 'L':
#			Inicio: Funcao: Limpa_Blocos
#			Fim: Funcao: Limpa_Blocos
#			j FIM_MOVIMENTA_JOGADOR
#		case 'K':
#			Inicio: Funcao: Mata_Inimigos
#			Fim: Funcao: Mata_Inimigos
#			j FIM_MOVIMENTA_JOGADOR
#ATUALIZA_POSICAO:		
#	R1{} = rJ + R1{}		## R1{} recebe a Nova posicao do Jogador ##
#	Se 0(R1{}) == 1:		## Isto eh: Ha colisao se Nova posicao do Jogador for um bloco indestrutível (pilastra)##
#		Pula para Funcao: Atualiza_Animacao		
#	Se nao:		
#		Se 0(R1{}) == 4:		## Isto eh: Jogador colidirah com Mob 1 ##
#			Funcao: Anda_Jogador
#			j Funcao: Configura_Colisao_Inimigo
#		Se nao se 0(R1{}) == 5:		## Isto eh: Jogador colidirah com Mob 2 ##
#			Funcao: Anda_Jogador
#			j Funcao: Configura_Colisao_Inimigo	
#		Se nao se 0(R1{}) == 6:		## Isto eh: Jogador pegarah em um PowerUp ##
#			Funcao: Anda_Jogador
#			j Funcao: Configura_PowerUp
#		Se nao se 0(R1{}) == 7:		## Isto eh: Jogador cairah em uma armadilha ##
#			Funcao: Anda_Jogador
#			j Funcao: Configura_Armadilha
#		Se nao:				## Jogador se movimentarah para um espaco vazio ##
#			Funcao_Anda_Jogador
#	j Funcao: Atualiza_Animacao
#FIM_MOVIMENTA_JOGADOR
#Fim: Funcao Movimenta_Jogador


#---------------------------------------------------------#
#         Consideracaoes para Movimenta_Mob1              |
#---------------------------------------------------------#
	## A posicao do MOB1 no tilemap estah sempre salva no mesmo registrador ao longo do jogo - rMOB1{} ##
	## Offset eh um numero usado para "desviar" ou "corrigir" outro numero ##
	## O apresentado abaixo eh apenas uma sugestao. O comportamento dos Mob1 ainda nao foi decidido ##
	## A Funcao: Atualiza_Animacao estah na biblioteca "Animacao" ##

####################################################################################
################### Computa a Movimentacao do MOB 2 ################################
####################################################################################
#Inicio: Funcao Movimenta_Mob1
#	Inicio: Funcao Define_offset_MOB1
#	FIM: Funcao Define_offset_MOB1		## Ao final o valor do offset eh guardado em R1{} ##
#	R1{} = rMOB1 + R1{}			## R1{} recebe a Nova posicao do MOB1 ##
#	Se R1{} t == 1:				## Isto é: Ha colisao se Nova posicao do MOB1 for um bloco indestrutível (pilastra)##
#		Pula para Funcao: Atualiza_Animacao
#	Se nao:
#		0(R1{}) = 0(rJ)		## Conteudo na posicao R1{} recebe o conteudo (valor) de MOB1 : MOB1 vai para o proximo quadrado do Tilemap ##
#		0(rJ) = 0		## Contudo na posicao do MOB1 se torna um espaco vazio ##	
#		rJ = R1			## Atualiza a posicao do MOB1 ##
#	Funcao: Atualiza_Animacao
#Fim: Funcao Movimenta_Mob1


#---------------------------------------------------------#
#         Consideracaoes para Movimenta_Mob2              |
#---------------------------------------------------------#
	## A posicao do MOB2 no tilemap estah sempre salva no mesmo registrador ao longo do jogo - rMOB2{} ##
	## Offset eh um numero usado para "desviar" ou "corrigir" outro numero ##
	## O apresentado abaixo eh apenas uma sugestao. O comportamento dos Mob2 ainda nao foi decidido ##
	## A Funcao: Atualiza_Animacao estah na biblioteca "Animacao" ##

####################################################################################
################### Computa a Movimentacao do MOB 2 ################################
####################################################################################
#Inicio: Funcao Movimenta_Mob2
#	Inicio: Funcao Define_offset_MOB2
#	FIM: Funcao Define_offset_MOB2		## Ao final o valor do offset eh guardado em R1{} ##
#	R1{} = rMOB2 + R1{}			## R1{} recebe a Nova posicao do MOB2 ##
#	Se R1{} t == 1:				## Isto é: Ha colisao se Nova posicao do MOB2 for um bloco indestrutível (pilastra)##
#		Pula para Funcao: Atualiza_Animacao
#	Se nao:
#		0(R1{}) = 0(rJ)		## Conteudo na posicao R1{} recebe o conteudo (valor) de MOB1 : MOB2 vai para o proximo quadrado do Tilemap ##
#		0(rJ) = 0		## Contudo na posicao do MOB2 se torna um espaco vazio ##	
#		rJ = R1			## Atualiza a posicao do MOB2 ##
#	Funcao: Atualiza_Animacao
#Fim: Funcao Movimenta_Mob2


######################################################################################################################################################
##########################################                    DESTRUICAO POR TILEMAP                      ############################################
######################################################################################################################################################

#---------------------------------------------------------#
#         Consideracaoes para Destroi_Explosivo           |
#---------------------------------------------------------#
	## Essa funcao soh eh executada depois que o tempo de existencia do explosivo chegou ao fim ##

####################################################################################
################### Computa a Explosao #############################################
####################################################################################
#Inicio: Funcao Destroi_Explosivo
#Fim: Funcao Destroi_Explosivo


#---------------------------------------------------------#
#         Consideracaoes para Destroi_Tijolo              |
#---------------------------------------------------------#
	## Essa funcao soh eh executada quando a explosao colide com um tijolo ##

####################################################################################
################### Computa a Destruicao do Tijolo #################################
####################################################################################
#Inicio: Funcao Destroi_Tijolo
#Fim: Funcao Destroi_Tijolo


######################################################################################################################################################
##########################################                    APARICAO POR TILEMAP                      ##############################################
######################################################################################################################################################

#---------------------------------------------------------#
#         Consideracaoes para Aparece_Explosivo           |
#---------------------------------------------------------#
	## Essa funcao soh eh executada depois que o tempo de existencia do explosivo chegou ao fim ##

####################################################################################
################### Computa a Aparicao do Explosivo ################################
####################################################################################
#Inicio: Funcao Aparece_Explosivo 
#Fim: Funcao Aparece_Explosivo 


#---------------------------------------------------------#
#         Consideracaoes para Aparece_Explosao            |
#---------------------------------------------------------#
	## Essa funcao soh eh executada depois que o tempo de existencia do explosivo chegou ao fim ##

####################################################################################
################### Computa a Aparicao da Explosao #################################
####################################################################################
#Inicio: Funcao Aparece_Explosao  
#Fim: Funcao Aparece_Explosao  


#---------------------------------------------------------#
#         Consideracaoes para Coloca_Especial             |
#---------------------------------------------------------#
	## Essa funcao soh eh executada apos a destruicao de um Bloco destrutivel (tijolo) ##
	## As probabilidades de aparicao ainda nao estao definidas ##
	## A funcao pode ser readapta para atender aa aparicao de mais Especiais ##
	## A Funcao: Preenche_Campo estah na biblioteca "RENDERIZA" ##
	#-----------------------------------------------------------------------------#
	##  Aplicacao da Funcao: Inteiro_Aleatorio: A decidir ##
		##
		##
		##
		##
		#mv R0{},a0
	#-----------------------------------------------------------------------------#	
	#-----------------------------------------------------------------------------#
	##  Aplicacao da Funcao: Define_Aparicao_Especial: A decidir. Ela definirah se aparecera o especial e se serah PowerUp ou Armadilha.##
	##  Retorna 0 se nao aparecerah especial, 1 se aparecerah PowerUp, 2 se aparecerah Armadilha  ##
		##
		##
		##
		##
		#mv R0{},a0
	#-----------------------------------------------------------------------------#	
####################################################################################
################### Computa a Aparicao do Especial #################################
####################################################################################
#Inicio: Funcao Coloca_Especial 
#	R1{} = Posicao_no_Tilemap
# 	R0{} = Funcao: Inteiro_aleatorio
#	R0{} = Funcao: Define_Aparicao_Especial
#	Se R0{} == 1:
#		0(R1{}) = 6
#	Se nao se R0{} == 2:
#		0(R1{}) = 7
#Fim: Funcao Coloca_Especial 
