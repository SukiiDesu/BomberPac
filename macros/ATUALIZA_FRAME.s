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
#    1--22----------4----333----4--1
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

#    |||||||||||||||||||||||||||||||
#    ||LLL|||||||||PP||||TIME||TTT||
#    |||||||||||||||||||||||||||||||
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