	la s0, TECLA_LIDA           # Pegue o endereco de TECLA_LIDA
    lw s0, 0(s0)

    la t1, BOOLEANO_FORCA			
    lw t1, 0(t1)				# Pegue o valor do Power Up

	###################
	## SWITCH LETRAS ##
	###################
	li t2, 'w'		            			# Pegue o valor 'w' na tabela ASCII	
    bne s0, t2, CASO_TECLA_a				# Se a tecla pressionada nao foi 'w'
		# Atualiza ULTIMA_TECLA_PRESSIONADA
		la t2, ULTIMA_TECLA_PRESSIONADA
		sw s0, 0(t2)
		
		la s6, IMAGEM_JOGADOR_cima
		li s5, -20
		mv s7, s0
		beqz t1, MOVIMENTA_JOGADOR			# Verifica Power Up
		la s6, IMAGEM_JOGADOR_FORCA_cima
		j MOVIMENTA_JOGADOR

	CASO_TECLA_a:
		li t2, 'a'		            # Pegue o valor 'a' na tabela ASCII	
		bne s0, t2, CASO_TECLA_s	# Se a tecla pressionada nao foi 'a'
			# Atualiza ULTIMA_TECLA_PRESSIONADA
			la t2, ULTIMA_TECLA_PRESSIONADA
			sw s0, 0(t2)
		
			la s6, IMAGEM_JOGADOR_esquerda
			li s5, -1
			mv s7, s0
			beqz t1, MOVIMENTA_JOGADOR			# Verifica Power Up
			la s6, IMAGEM_JOGADOR_FORCA_esquerda
			j MOVIMENTA_JOGADOR

	CASO_TECLA_s:
		li t2, 's'		            # Pegue o valor S na tabela ASCII	
		bne s0, t2, CASO_TECLA_d	# Se a tecla pressionada nao foi 's'
			# Atualiza ULTIMA_TECLA_PRESSIONADA
			la t2, ULTIMA_TECLA_PRESSIONADA
			sw s0, 0(t2)
			
			la s6, IMAGEM_JOGADOR_baixo
			li s5, 20
			mv s7, s0
			beqz t1, MOVIMENTA_JOGADOR			# Verifica Power Up
			la s6, IMAGEM_JOGADOR_FORCA_baixo
			j MOVIMENTA_JOGADOR

	CASO_TECLA_d:
		li t2, 'd'		            # Pegue o valor 'd' na tabela ASCII	
		bne s0, t2, CASO_TECLA_x	# Se a tecla pressionada nao foi 'd'
			# Atualiza ULTIMA_TECLA_PRESSIONADA
			la t2, ULTIMA_TECLA_PRESSIONADA
			sw s0, 0(t2)
			
			la s6, IMAGEM_JOGADOR_direita
			li s5, 1
			mv s7, s0
			beqz t1, MOVIMENTA_JOGADOR			# Verifica Power Up
			la s6, IMAGEM_JOGADOR_FORCA_direita
			j MOVIMENTA_JOGADOR

	CASO_TECLA_x:
		li t2, 120		            # Pegue o valor 'L' na tabela ASCII	
		bne s0, t2, CASO_TECLA_j	# Se a tecla pressionada nao foi 'K'
			# Confere se POWERUP FORCA estah ativo
			la t1, BOOLEANO_FORCA
			lw t1, 0(t1)
			beqz t1, CASO_TECLA_L

			# Verifica a direcao que o Jogador estah olhando
			# t1 = ULTIMA_TECLA_PRESSIONADA
			la t2, ULTIMA_TECLA_PRESSIONADA
			lw t1, 0(t2)

			# Pega posicao do jogador
			# t0 = POSICAO_ATUAL_JOGADOR
			la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
			lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    
			# Caso de verificacao da direcao
			# Se houver tijolo na direcao que o personagem estah
			# olhando, o tijolo serah destruido
			
			li s4, 40	# Parametro para calculo de spawn aleatorio
			# Caso esteja olhando para cima
			li t2, 'w'
			bne t1, t2, CASO_SOCO_ESQUERDA   # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
			addi t0, t0, -20                # Adicone o offset
			call DestroiTijolo
			j MOVIMENTA_INIMIGOS

			# Caso esteja olhando para esquerda
			CASO_SOCO_ESQUERDA:
			li t2, 'a'
			bne t1, t2, CASO_SOCO_BAIXO   # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
			addi t0, t0, -1                # Adicone o offset
			call DestroiTijolo
			j MOVIMENTA_INIMIGOS

			# Caso esteja olhando para esquerda
			CASO_SOCO_BAIXO:
			li t2, 's'
			bne t1, t2, CASO_SOCO_DIREITA   # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
			addi t0, t0, 20                # Adicone o offset
			call DestroiTijolo
			j MOVIMENTA_INIMIGOS

			# Caso esteja olhando para esquerda
			CASO_SOCO_DIREITA:
			li t2, 'd'
			bne t1, t2, MOVIMENTA_INIMIGOS  # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
			addi t0, t0, 1                  # Adicone o offset
			call DestroiTijolo
			j MOVIMENTA_INIMIGOS

	CASO_TECLA_j:
		li t2, 106		            # Pegue o valor 'j' na tabela ASCII	
		bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'j'

			# Verifica a direcao que o Jogador esta olhando
			la t2, ULTIMA_TECLA_PRESSIONADA
			lw t1, 0(t2)

			# Pega posicao do jogador
			la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
			lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR

			# Caso esteja olhando para cima
			li t2, 'w'
			bne t1, t2, CASO_BOMBA_ESQUERDA
			addi t0, t0, -20                # Adicone o offset
			j COLISAO_CHECK

			# Caso esteja olhando para esquerda
			CASO_BOMBA_ESQUERDA:
			li t2, 'a'
			bne t1, t2, CASO_BOMBA_BAIXO
			addi t0, t0, -1                # Adicone o offset
			j COLISAO_CHECK

			# Caso esteja olhando para baixo
			CASO_BOMBA_BAIXO:
			li t2, 's'
			bne t1, t2, CASO_BOMBA_DIREITA
			addi t0, t0, 20                # Adicone o offset
			j COLISAO_CHECK

			# Caso esteja olhando para direita
			CASO_BOMBA_DIREITA:
			li t2, 'd'
			bne t1, t2, MOVIMENTA_INIMIGOS
			addi t0, t0, 1        	   # Adicone o offset
			
			COLISAO_CHECK:
			lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
			add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
			lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

			li t2, 8                          
			bne s3, t2, MOVIMENTA_INIMIGOS    # Nova posicao disponivel para colocar bomba (Vazio)

			## COLOCAR A BOMBA ##
			li t2, 7
			sb t2, 0(s1)    # Coloca a Bomba
    

# 	CASO_TECLA_K:
# 		li t2, 'K'		            # Pegue o valor 'L' na tabela ASCII	
# 		bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'K'

# 		## EVENTO : MATA_INIMIGOS ##
# 		li t0, 41		    # Primeira matriz do APAGA_BLOCOS
# 		li t4, 278		    # Ultima matriz do tilemap
# 		lw s2, TILEMAP_MUTAVEL	# Pegue o endereco do Tilemap
# 		LOOP_TILEMAP_APAGA_BLOCOS:
# 			bgt t0, t4, MOVIMENTA_INIMIGOS		# Enquanto t0 < ultima matriz do tilemap, faca o abaixo
# 			add s2, s2, t0	        # Itere o endereco do byte no tilemap
# 			lb t5, 0(s2)	        # Valor da matriz no Tilemap

# 			## O caso abaixo substitui o tijolo por um espaço vazio ##
# 			li t2, 3		                            # Pegue o valor 0
# 			bne t5, t2, ITERA_LOOP_TILEMAP_APAGA_BLOCOS	# Compare com o valor no byte atual do Tilemap
# 				call DestroiTijolo
# 				ITERA_LOOP_TILEMAP_APAGA_BLOCOS:
# 					addi t0, t0, 1	                      # t0++
# 					li s4, 20                             # s4 = 20
# 					rem s4, t0, s4                        # s4 = t0 % 20
# 					li s5, 19                             # s5 = 19
# 					bne s4, s5, LOOP_TILEMAP_APAGA_BLOCOS # Se s4 != 19 -> LOOP_TILEMAP_CAMPO
# 					addi t0, t0, 2                        # s4 == 19 -> Some 2 : Pule colunas indestrutiveis
# 					j LOOP_TILEMAP_APAGA_BLOCOS           # Retorne para a verificacao do Loop que percorre o Tilemap

	CASO_TECLA_L:
		li t2, 'L'		            # Pegue o valor 'L' na tabela ASCII	
		bne s0, t2, CASO_TECLA_P	# Se a tecla pressionada nao foi 'L'	

		## EVENTO : LIMPA BLOCOS ##
		li t0, 41		    # Primeira matriz do APAGA_BLOCOS
		li t4, 278		    # Ultima matriz do tilemap
		LOOP_TILEMAP_APAGA_BLOCOS:
			bgt t0, t4, MOVIMENTA_INIMIGOS		# Enquanto t0 < ultima matriz do tilemap, faca o abaixo
			
			lw s2, TILEMAP_MUTAVEL	# Pegue o endereco do Tilemap
			add s2, s2, t0	        # Itere o endereco do byte no tilemap
			lb t5, 0(s2)	        # Valor da matriz no Tilemap

		## O caso abaixo substitui o tijolo por um espaço vazio ##
			li t2, 3		                            # Pegue o valor 0
			bne t5, t2, ITERA_LOOP_TILEMAP_APAGA_BLOCOS	# Compare com o valor no byte atual do Tilemap
				li s4, 10
				call DestroiTijolo
				ITERA_LOOP_TILEMAP_APAGA_BLOCOS:
					addi t0, t0, 1	                      # t0++
					li s4, 20                             # s4 = 20
					rem s4, t0, s4                        # s4 = t0 % 20
					li s5, 19                             # s5 = 19
					bne s4, s5, LOOP_TILEMAP_APAGA_BLOCOS # Se s4 != 19 -> LOOP_TILEMAP_CAMPO
					addi t0, t0, 2                        # s4 == 19 -> Some 2 : Pule colunas indestrutiveis
					j LOOP_TILEMAP_APAGA_BLOCOS           # Retorne para a verificacao do Loop que percorre o Tilemap

	CASO_TECLA_P:
		li t2, 'P'			# Pegue o valor 'P' na tabela ASCII	
		# O ultimo caso possui uma comparacao oposta dos demais (!= ao inves de ==).
		bne s0, t2, MOVIMENTA_INIMIGOS	# Se a tecla pressionada nao foi 'P'
		## EVENTO : PROXIMA_FASE ##
		la t0, FASE_ATUAL
		lw t0, 0(t0)
		li t1, 1
		beq t0, t1, PASSA_FASE_2    # Passa para a fase 2, caso estejah na fase 1
		j FIM_GAME_LOOP_FASE_1      # Encerra Game_Loop, caso estejah na fase 2

# t0 = Posicao do tijolo
# s4 = Valor inicial para calculo do randomizador
DestroiTijolo:
	lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
	add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
	lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

	li t2, 3                          # Pegue o valor 3
	bne s3, t2, FimDestroiTijolo    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

	## Destroi bloco ## 
		li a7, 30   # Chama tempo atual
		ecall

		# Seta a seed com base no tempo atual
		mv a1, a0   
		li a0, 0
		li a7, 40
		ecall

		# Pega um numero aleatorio de [0, 99] 
		li a1, 99
		li a7, 42
		ecall

		# Se numero aleatorio > 30 -> Nao haverah powerup/armadilha
		bgt a0, s4, ESVAZIA_ESPACO

		mv t2, a0
		srli t2, t2, 1  # t2 = t2//2
		srli s4, s4, 2	# s4 = s4//2

		# Se t2 > s4 -> Haverah power Up, se nao haverah armadilha
		bge t2, s4, SURGE_POWER_UP

		SURGE_ARMADILHA:
			li t3, 7
			sb t3, 0(s1)
			j FimDestroiTijolo

		SURGE_POWER_UP:
			li t3, 6
			sb t3, 0(s1)
			j FimDestroiTijolo

		ESVAZIA_ESPACO:
			li t2, 0        # Pegue o valor 0
			sb t2, 0(s1)    # Atualiza matriz Tijolo para Campo vazio
FimDestroiTijolo:
	ret

# s5 = Offset
# s6 = IMAGEM_ATUAL do Jogador
# s7 = Letra pressionada
# Os casos abaixos definem o evento que ocorrerah
MOVIMENTA_JOGADOR:
	# Atualiza Sprite do Jogador com a IMAGEM_ATUAL
    la t5, IMAGEM_JOGADOR	
    sw s6, 0(t5)			

	######################################################
	## Define Sprite com base se o POWER UP estah ativo ##
	######################################################
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    add t0, t0, s5            	# Adicone o offset

    lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

    ## EVENTO: COLISAO BLOCOS ##
    li t2, 1                            # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
    li t2, 7                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    ## EVENTO: POWERUP FORCA ##
    li t2, 6
    bne s3, t2, COLISAO_INIMIGO

		# Ativa PowerUp Forca
		la t1, BOOLEANO_FORCA
		li t2, 1
		sw t2, 0(t1)

		# Atualiza SPRITE de FORCA
			# Switch letras #
		li t2, 'w'
		bne s7, t2, CASO_POWERUP_a
			la s6, IMAGEM_JOGADOR_FORCA_cima
			sw s6, 0(t5)
			j ATUALIZA_JOGADOR

		CASO_POWERUP_a:
		li t2, 'a'
		bne s7, t2, CASO_POWERUP_s
			la s6, IMAGEM_JOGADOR_FORCA_esquerda
			sw s6, 0(t5)
			j ATUALIZA_JOGADOR

		CASO_POWERUP_s:
		li t2, 's'
		bne s7, t2, CASO_POWERUP_d
			la s6, IMAGEM_JOGADOR_FORCA_baixo
			sw s6, 0(t5)
			j ATUALIZA_JOGADOR

		CASO_POWERUP_d:
			la s6, IMAGEM_JOGADOR_FORCA_direita
			sw s6, 0(t5)
			j ATUALIZA_JOGADOR

	## EVENTO: COLISAO COM INIMIGO
	COLISAO_INIMIGO:
		la t3, POSICAO_INIMIGOS		# Pegue endereco do vetor POSICAO_INIMIGOS
		
		# Inicializa indices do loop
		li s4, 0
		la s6, QUANTIDADE_DE_INIMIGOS
		lb s6, 0(s6)

		LOOP_CONFERE_COLISAO_INIMIGO:
			beq s4, s6, COLETA_PONTO
				lw t2, 0(t3)

				# li a7, 4
				# la a0, DEBUG_MSG
				# ecall

				bne t0, t2, ITERA_LOOP_CONFERE_COLISAO_INIMIGO

				la t2, VIDAS
				lw t4, 0(t2)
				addi t4, t4, -1
				sw t4, 0(t2)

				J ATUALIZA_JOGADOR

			ITERA_LOOP_CONFERE_COLISAO_INIMIGO:
				addi s4, s4, 1
				addi t3, t3, 4
				j LOOP_CONFERE_COLISAO_INIMIGO

    ## EVENTO: COLETA PONTO
    COLETA_PONTO:
		li t2, 8
		bne s3, t2, ATUALIZA_JOGADOR
		la t1, PONTOS
		lw t2, 0(t1)
		addi t2, t2, 1
		sw t2, 0(t1)

    ATUALIZA_JOGADOR:
		# Preenche o espaco com o "conteudo" jogador
		## Gambiarra para evitar flick de renderizacao ##
		# li t2, 4
		# sb t2, 0(s1)

    	# MOVIMENTA O JOGADOR #
		# Inverte o Offset
		li t2, -1
		mul s5, s5, t2
		# Retira offset
		add s1, s1, s5	    

		# Apaga o rastro do Jogador, deixando um campo vazio atras dele
		li t2, 0        	# Pegue o valor 0
		sb t2, 0(s1)    	# Apaga rastro do Jogador
		sw t0, 0(s0)        # Atualiza POSICAO_JOGADOR

    j MOVIMENTA_INIMIGOS

MOVIMENTA_INIMIGOS:
	
	# # # Movimenta Inimigos
	# la s5 POSICAO_INIMIGOS

	# la t0, FASE_ATUAL
	# lw t0, 0(t0)
	# li t2, 1
	# bne t0, t2, INIMIGO_TIPO_2

	# # Movimentacao do Inimigo Tipo 1 (Linhas Horizontais ou Verticais)
	# li s6, 0
	# la s8, QUANTIDADE_DE_INIMIGOS
	# lb s8, 0(s8)
	# LOOP_MOVIMENTA_INIMIGOS:
	# 	beq s6, s8, FIM_LOOP_MOVIMENTA_INIMIGOS
	# 	lw t5, 0(s7) 
	# 	lw t0, 0(s5)
	#	li t1, -1
	#	beq t0, t1, PULA_RENDERIZACAO	#Verifica se o inimigo estah morto
	# 	call RenderizacaoDinamica
	#   PULA_RENDERIZACAO:
	# 	addi s5, s5, 4

	# 	addi s6, s6, 1
	# 	j LOOP_MOVIMENTA_INIMIGOS
	# FIM_LOOP_RENDERIZA_INIMIGOS:


	# INIMIGO_TIPO_2:
	# # Movimentacao do Inimigo Tipo 1 (Offset randomizado apos colisao)


	# # SWITCH - OFFSET_INIMIGO

	# # Atualiza Frames de Inimigos
	# # la s7 IMAGEM_INIMIGOS
	# li s6, 0
	# li s8, 2
	# 	addi s7, s7, 4

FIM_ATUALIZA_TILEMAP:
