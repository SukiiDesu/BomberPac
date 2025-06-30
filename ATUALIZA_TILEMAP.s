	la s0, TECLA_LIDA           # Pegue o endereco de TECLA_LIDA
    lw s0, 0(s0)

# Os casos abaixos definem o evento que ocorrerah
CASO_TECLA_w:
    li t2, 119		            # Pegue o valor 'w' na tabela ASCII	
    bne s0, t2, CASO_TECLA_a	# Se a tecla pressionada nao foi 'w'

    la t2, ULTIMA_TECLA_PRESSIONADA
	li t1, 'w'
    sw t1, 0(t2)

    la t1, BOOLEANO_FORCA
    lw t1, 0(t1)
    beqz t1, IMAGEM_JOGADOR_NORMAL_W

    IMAGEM_JOGADOR_FORTE_W:
    la t1, IMAGEM_JOGADOR_FORCA_cima	# pega o endereco de "IMAGEM_JOGADOR_cima" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5
    j ATUALIZA_JOGADOR_W

    IMAGEM_JOGADOR_NORMAL_W:
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_cima	# pega o endereco de "IMAGEM_JOGADOR_cima" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    ATUALIZA_JOGADOR_W:
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, -20            # Adicone o offset

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
    bne s3, t2, COLETA_PONTO_CIMA
    la t1, BOOLEANO_FORCA
    li t2, 1
    sw t2, 0(t1)

    la t1, IMAGEM_JOGADOR_FORCA_cima	# pega o endereco de "IMAGEM_JOGADOR_cima" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5
    j MOVIMENTA_JOGADOR_CIMA

    ## EVENTO: COLETA PONTO
    COLETA_PONTO_CIMA:
    li t2, 8
    bne s3, t2, MOVIMENTA_JOGADOR_CIMA
    la t1, PONTOS
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    MOVIMENTA_JOGADOR_CIMA:
    # Movimento em TILEMAP
    li t2, 4
    sb t2, 0(s1)

    # Movimenta Jogador
    addi s1, s1, 20	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador
    sw t0, 0(s0)        # Atualiza POSICAO_JOGADOR

    j MOVIMENTA_INIMIGOS

CASO_TECLA_a:
    li t2, 97		            # Pegue o valor 'a' na tabela ASCII	
    bne s0, t2, CASO_TECLA_s	# Se a tecla pressionada nao foi 'a'

    la t2, ULTIMA_TECLA_PRESSIONADA
	li t1, 'a'
    sw t1, 0(t2)

    la t1, BOOLEANO_FORCA
    lw t1, 0(t1)
    beqz t1, IMAGEM_JOGADOR_NORMAL_A

    IMAGEM_JOGADOR_FORTE_A:
    la t1, IMAGEM_JOGADOR_FORCA_esquerda	# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5
    j ATUALIZA_JOGADOR_A

    IMAGEM_JOGADOR_NORMAL_A:
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_esquerda	# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    ATUALIZA_JOGADOR_A:
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, -1             # Adicone o offset

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
    bne s3, t2, COLETA_PONTO_ESQUERDA
    la t1, BOOLEANO_FORCA
    li t2, 1
    sw t2, 0(t1)

    la t1, IMAGEM_JOGADOR_FORCA_esquerda	# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5

    ## EVENTO: COLETA PONTO
    COLETA_PONTO_ESQUERDA:
    li t2, 8
    bne s3, t2, MOVIMENTA_JOGADOR_ESQUERDA
    la t1, PONTOS
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    MOVIMENTA_JOGADOR_ESQUERDA:
    # ANDA JOGADOR PARA A ESQUERDA
    li t2, 4
    sb t2, 0(s1)        # Movimenta o JOGADOR
    addi s1, s1, 1	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)        # Apague rastro do Jogador
    sw t0, 0(s0)        # Atualiza POSICAO_JOGADOR

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

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
    bne s3, t2, COLETA_PONTO_BAIXO
    la t1, BOOLEANO_FORCA
    li t2, 1
    sw t2, 0(t1)

    la t1, IMAGEM_JOGADOR_FORCA_baixo	# pega o endereco de "IMAGEM_JOGADOR_baixo" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5

    ## EVENTO: COLETA PONTO
    COLETA_PONTO_BAIXO:
    li t2, 8
    bne s3, t2, MOVIMENTA_JOGADOR_BAIXO
    la t1, PONTOS
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    MOVIMENTA_JOGADOR_BAIXO:
    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR
    addi s1, s1, -20	# Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador
    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR
    j MOVIMENTA_INIMIGOS	

CASO_TECLA_d:
    li t2, 100		            # Pegue o valor 'd' na tabela ASCII	
    bne s0, t2, CASO_TECLA_x	# Se a tecla pressionada nao foi 'd'    # Corrigir PRIMEIRO salto para CASO_TECLA_L, DEPOIS para CASO_TECLA_L

    la t2, ULTIMA_TECLA_PRESSIONADA
	li t1, 'd'
    sw t1, 0(t2)

    la t1, BOOLEANO_FORCA
    lw t1, 0(t1)
    beqz t1, IMAGEM_JOGADOR_NORMAL_D

    IMAGEM_JOGADOR_FORTE_D:
    la t1, IMAGEM_JOGADOR_FORCA_direita	# pega o endereco de "IMAGEM_JOGADOR_direita" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5
    j ATUALIZA_JOGADOR_D

    IMAGEM_JOGADOR_NORMAL_D:
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_direita	# pega o endereco de "IMAGEM_JOGADOR_direita" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    ATUALIZA_JOGADOR_D:
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, 1              # Adicone o offset

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
    bne s3, t2, COLETA_PONTO_DIREITA
    la t1, BOOLEANO_FORCA
    li t2, 1
    sw t2, 0(t1)

    la t1, IMAGEM_JOGADOR_FORCA_direita	# pega o endereco de "IMAGEM_JOGADOR_direita" e coloca em t1
    la t5, IMAGEM_JOGADOR		        # pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			            # coloca o endereco de t1 no endereco de t5

    ## EVENTO: COLETA PONTO
    COLETA_PONTO_DIREITA:
    li t2, 8
    bne s3, t2, MOVIMENTA_JOGADOR_DIREITA
    la t1, PONTOS
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    MOVIMENTA_JOGADOR_DIREITA:
    # ANDA JOGADOR PARA A DIREITA
    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR
    addi s1, s1, -1	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador
    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_x:
    li t2, 120		            # Pegue o valor 'L' na tabela ASCII	
    bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'K'

    # Confere se estah com o POWERUP FORCA
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
    
    # Caso esteja olhando para cima
    li t2, 'w'
    bne t1, t2, CASO_SOCO_ESQUERDA   # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
    addi t0, t0, -20                # Adicone o offset
    j DESTROI_BLOCO_X

    # Caso esteja olhando para esquerda
    CASO_SOCO_ESQUERDA:
    li t2, 'a'
    bne t1, t2, CASO_SOCO_BAIXO   # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
    addi t0, t0, -1                # Adicone o offset
    j DESTROI_BLOCO_X

    # Caso esteja olhando para esquerda
    CASO_SOCO_BAIXO:
    li t2, 's'
    bne t1, t2, CASO_SOCO_DIREITA   # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
    addi t0, t0, 20                # Adicone o offset
    j DESTROI_BLOCO_X

    # Caso esteja olhando para esquerda
    CASO_SOCO_DIREITA:
    li t2, 'd'
    bne t1, t2, MOVIMENTA_INIMIGOS  # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)
    addi t0, t0, 1                  # Adicone o offset

    DESTROI_BLOCO_X:
    lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

    li t2, 3                          # Pegue o valor 3
    bne s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

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
        li t3, 40
        bgt a0, t3, ESVAZIA_ESPACO_X

        mv t2, a0
        srli t2, t2, 1  # t2 = t2//2

        # Se t2 > 10 -> Haverah power Up, se nao haverah armadilha
        li t3, 10
        bge t2, t3, SURGE_POWER_UP_X

        SURGE_ARMADILHA_X:
            li t3, 7
            sb t3, 0(s1)
            j MOVIMENTA_INIMIGOS 

        SURGE_POWER_UP_X:
            li t3, 6
            sb t3, 0(s1)
            j MOVIMENTA_INIMIGOS 

        ESVAZIA_ESPACO_X:
            li t2, 0        # Pegue o valor 0
            sb t2, 0(s1)    # Atualiza matriz Tijolo para Campo vazio 
            j MOVIMENTA_INIMIGOS 

# CASO_TECLA_K:
# 		li t2, 75		            # Pegue o valor 'L' na tabela ASCII	
# 		bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'K'

        ## EVENTO : MATA INIMIGOS ##

# 		la s0, IMAGEM_3		# Se o byte atual == 2, pegue a imagem_2
# 		j FIM_ATUALIZA_TILEMAP      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_L:
    li t2, 76		            # Pegue o valor 'L' na tabela ASCII	
    bne s0, t2, CASO_TECLA_P	# Se a tecla pressionada nao foi 'L'

    ## EVENTO : LIMPA BLOCOS ##
    li t0, 41		    # Primeira matriz do APAGA_BLOCOS
    li t1, 278		    # Ultima matriz do tilemap

    LOOP_TILEMAP_APAGA_BLOCOS:
        bgt t0, t1, MOVIMENTA_INIMIGOS		# Enquanto t0 < ultima matriz do tilemap, faca o abaixo

        lw s2, TILEMAP_MUTAVEL	# Pegue o endereco do Tilemap
        add s2, s2, t0	        # Itere o endereco do byte no tilemap
        lb t5, 0(s2)	        # Valor da matriz no Tilemap

    ## O caso abaixo substitui o tijolo por um espaço vazio ##
        li t2, 3		                            # Pegue o valor 0
        bne t5, t2, ITERA_LOOP_TILEMAP_APAGA_BLOCOS	# Compare com o valor no byte atual do Tilemap

        ######################################################
        #### RANDOMIZA A APARICAO DE ARMADILHAS E POWERUPS ###
        ######################################################

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
        li t3, 10
        bgt a0, t3, ESVAZIA_ESPACO_L

        mv t2, a0
        srli t2, t2, 1  # t2 = t2//2

        # Se t2 > 8 -> Haverah power Up, se nao haverah armadilha
        li t3, 3
        bge t2, t3, SURGE_POWER_UP_L

        SURGE_ARMADILHA_L:
            li t3, 7
            sb t3, 0(s2)
            j ITERA_LOOP_TILEMAP_APAGA_BLOCOS

        SURGE_POWER_UP_L:
            li t3, 6
            sb t3, 0(s2)
            j ITERA_LOOP_TILEMAP_APAGA_BLOCOS

        ESVAZIA_ESPACO_L:
            li t2, 0        # Pegue o valor 0
            sb t2, 0(s2)    # Atualiza matriz Tijolo para Campo vazio 

    ITERA_LOOP_TILEMAP_APAGA_BLOCOS:
        addi t0, t0, 1	                      # t0++
        li s4, 20                             # s4 = 20
        rem s4, t0, s4                        # s4 = t0 % 20
        li s5, 19                             # s5 = 19
        bne s4, s5, LOOP_TILEMAP_APAGA_BLOCOS # Se s4 != 19 -> LOOP_TILEMAP_CAMPO
        addi t0, t0, 2                        # s4 == 19 -> Some 2 : Pule colunas indestrutiveis
        j LOOP_TILEMAP_APAGA_BLOCOS           # Retorne para a verificacao do Loop que percorre o Tilemap

CASO_TECLA_P:
    li t2, 80			# Pegue o valor 'P' na tabela ASCII	
    # O ultimo caso possui uma comparacao oposta dos demais (!= ao inves de ==).
    bne s0, t2, MOVIMENTA_INIMIGOS	# Se a tecla pressionada nao foi 'P'

    ## EVENTO : PROXIMA_FASE (POR ENQUANTO ENCERRA O JOGO) ##

    la t0, FASE_ATUAL
    lw t0, 0(t0)

    li t1, 1
    beq t0, t1, PASSA_FASE_2            # Passa para a fase 2
    j FIM_GAME_LOOP_FASE_1              # Encerra Game_Loop

MOVIMENTA_INIMIGOS:     # Por enquanto ainda nao ha inimigos
    ### Colocar inimigos ####

FIM_ATUALIZA_TILEMAP:

