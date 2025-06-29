    CASO_TECLA_s:
        li t2, 115		            # Pegue o valor S na tabela ASCII	
        bne s0, t2, CASO_TECLA_d	# Se a tecla pressionada nao foi 's'

        la t2, ULTIMA_TECLA_PRESSIONADA
        li t1, 's'
        sw t1, 0(t2)

        la t1, BOOLEANO_FORCA
        lw t1, 0(t1)
        beqz t1, IMAGEM_JOGADOR_NORMAL_S

        IMAGEM_JOGADOR_FORTE_S:
        la t1, IMAGEM_JOGADOR_FORCA_baixo	# pega o endereco de "IMAGEM_JOGADOR_baixo" e coloca em t1
        la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
        sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5
        j ATUALIZA_JOGADOR_S

        IMAGEM_JOGADOR_NORMAL_S:
        ## atualiza sprite jogador ##
        la t1, IMAGEM_JOGADOR_baixo	# pega o endereco de "IMAGEM_JOGADOR_baixo" e coloca em t1
        la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
        sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

        ATUALIZA_JOGADOR_S:
        la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
        lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
        addi t0, t0, 20             # Adicone o offset

        lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
        add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
        lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

        ## EVENTO: COLISAO BLOCOS ##
        li t2, 1                            # Pegue o valor 1
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
        li t2, 3                            # Pegue o valor 3
        beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

        ## EVENTO: POWERUP FORCA ##
        li t2, 6
        bne s3, t2, MOVIMENTA_JOGADOR_BAIXO
        la t1, BOOLEANO_FORCA
        li t2, 1
        sw t2, 0(t1)

        la t1, IMAGEM_JOGADOR_FORCA_baixo	# pega o endereco de "IMAGEM_JOGADOR_baixo" e coloca em t1
        la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
        sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5

        MOVIMENTA_JOGADOR_BAIXO:
        li t2, 4
        sb t2, 0(s1)    # Movimenta o JOGADOR

        addi s1, s1, -20	# Retira offset
        li t2, 0        	# Pegue o valor 0
        sb t2, 0(s1)    	# Apague rastro do Jogador

        sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

        j MOVIMENTA_INIMIGOS	