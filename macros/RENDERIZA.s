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
	# Como que "acompanha" qual etapa da animacao deve ser renderizada ???????? Deve ser feito em ATUALIZA_FRAME????
	# "Conferir passagem dos registradores"
	# Para todas as imagens necessarias:
		# Carrega endereco da imagem em um registrador
		# Desenha_imagem(%reg) # Chama Desenha_imagem com o registrador que guarda o endereco correto para desenho do objeto



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