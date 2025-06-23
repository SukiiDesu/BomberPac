	la s0, TECLA_LIDA           # Pegue o endereco de TECLA_LIDA
    lw s0, 0(s0)

# Os casos abaixos definem o evento que ocorrerah
CASO_TECLA_w:
		li t2, 119		            # Pegue o valor 'w' na tabela ASCII	
		bne s0, t2, CASO_TECLA_a	# Se a tecla pressionada nao foi 'w'
        
		la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
        lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
        addi t0, t0, -20             # Adicone o offset

        la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
        add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
        lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


        ## EVENTO: COLISAO BLOCOS ##
        li t2, 1                            # Pegue o valor 1
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
        li t2, 3                            # Pegue o valor 3
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

		li t2, 4
        sb t2, 0(s1)    # Movimenta o JOGADOR

		addi s1, s1, 20	    # Retira offset
        li t2, 0        	# Pegue o valor 0
        sb t2, 0(s1)    	# Apague rastro do Jogador

        sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

		j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		


CASO_TECLA_a:
		li t2, 97		            # Pegue o valor 'a' na tabela ASCII	
		bne s0, t2, CASO_TECLA_s	# Se a tecla pressionada nao foi 'a'
        
		la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
        lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
        addi t0, t0, -1             # Adicone o offset

        la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
        add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
        lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


        ## EVENTO: COLISAO BLOCOS ##
        li t2, 1                            # Pegue o valor 1
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
        li t2, 3                            # Pegue o valor 3
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

		li t2, 4
        sb t2, 0(s1)    # Movimenta o JOGADOR

		addi s1, s1, 1	    # Retira offset
        li t2, 0        	# Pegue o valor 0
        sb t2, 0(s1)    	# Apague rastro do Jogador

        sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

		j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_s:
		li t2, 115		            # Pegue o valor S na tabela ASCII	
		bne s0, t2, CASO_TECLA_d	# Se a tecla pressionada nao foi 's'
        
		la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
        lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
        addi t0, t0, 20             # Adicone o offset

        la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
        add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
        lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


        ## EVENTO: COLISAO BLOCOS ##
        li t2, 1                            # Pegue o valor 1
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
        li t2, 3                            # Pegue o valor 3
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

		li t2, 4
        sb t2, 0(s1)    # Movimenta o JOGADOR

		addi s1, s1, -20	# Retira offset
        li t2, 0        	# Pegue o valor 0
        sb t2, 0(s1)    	# Apague rastro do Jogador

        sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

		j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_d:
		li t2, 100		            # Pegue o valor 'd' na tabela ASCII	
		bne s0, t2, CASO_TECLA_P	# Se a tecla pressionada nao foi 'd'    # Corrigir PRIMEIRO salto para CASO_TECLA_L, DEPOIS para CASO_TECLA_L
        
		la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
        lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
        addi t0, t0, 1              # Adicone o offset

        la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
        add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
        lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


        ## EVENTO: COLISAO BLOCOS ##
        li t2, 1                            # Pegue o valor 1
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
        li t2, 3                            # Pegue o valor 3
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

		li t2, 4
        sb t2, 0(s1)    # Movimenta o JOGADOR

		addi s1, s1, -1	    # Retira offset
        li t2, 0        	# Pegue o valor 0
        sb t2, 0(s1)    	# Apague rastro do Jogador

        sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

		j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

# CASO_TECLA_K:
# 		li t2, 75		            # Pegue o valor 'L' na tabela ASCII	
# 		bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'K'

        ## EVENTO : MATA INIMIGOS ##

# 		la s0, IMAGEM_3		# Se o byte atual == 2, pegue a imagem_2
# 		j FIM_ATUALIZA_TILEMAP      # Encerra ATUALIZA_FRAME.s		

# CASO_TECLA_L:
# 		li t2, 76		            # Pegue o valor 'L' na tabela ASCII	
# 		bne s0, t2, CASO_TECLA_P	# Se a tecla pressionada nao foi 'L'

    ## EVENTO : LIMPA BLOCOS ##
	# li t0, 41		    # Primeira matriz do CAMPO
	# li t1, 278		    # Ultima matriz do tilemap
    # j MOVIMENTA_INIMIGOS        # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_P:
		li t2, 80			# Pegue o valor 'P' na tabela ASCII	
		# O ultimo caso possui uma comparacao oposta dos demais (!= ao inves de ==).
		bne s0, t2, MOVIMENTA_INIMIGOS	# Se a tecla pressionada nao foi 'P'

        ## EVENTO : PROXIMA_FASE (POR ENQUANTO ENCERRA O JOGO) ##
		j FIM_GAME_LOOP_FASE_1              # Encerra Game_Loop
        la s0, IMAGEM_JOGADOR			    # Se o byte atual == 3, pegue a imagem_3

MOVIMENTA_INIMIGOS:     # Por enquanto ainda nao ha inimigos

FIM_ATUALIZA_TILEMAP: