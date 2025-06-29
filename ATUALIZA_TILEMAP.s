	la s0, TECLA_LIDA           # Pegue o endereco de TECLA_LIDA
    lw s0, 0(s0)

# Os casos abaixos definem o evento que ocorrerah
CASO_TECLA_w:
    li t2, 119		            # Pegue o valor 'w' na tabela ASCII	
    bne s0, t2, CASO_TECLA_a	# Se a tecla pressionada nao foi 'w'

    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_cima		# pega o endereco de "IMAGEM_JOGADOR_cima" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5 

    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, -20            # Adicone o offset

    lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

    ## EVENTO: COLISAO BLOCOS ##
    COLISAO_BLOCOS_W:
    li t2, 1                          # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                          # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    # Movimento em TILEMAP
    li t2, 4
    sb t2, 0(s1)

    # Movimenta Jogador
    addi s1, s1, 20	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador
    sw t0, 0(s0)        # Atualiza POSICAO_JOGADOR
    j MOVIMENTA_INIMIGOS

    # # Atualiza Ultima Tecla lida
	# la t6, ULTIMA_TECLA_LIDA
    # li s0, 'w'
	# sw s0, 0(t6)

    # ## EVENTO: PEGAR PONTOS ##
    # li t2, 8                      # Pegue o valor 1
    # bne s3, t2, PEGAR_POWER_UP    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    # # Pontos++
    # la t2, PONTOS
    # lw t3, 0(t2)
    # addi t3, t3, 1
    # sw t3, 0(t2)
    # j MOVIMENTA_INIMIGOS

    # ## EVENTO: PEGAR POWER UP ##
    # PEGAR_POWER_UP:
    # li t2, 6                                # Pegue o valor 1
    # bne s3, t2, CAIR_EM_ARMADILHA           # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    # ## Reseta timer do power up ##
    # la t3, TEMPO_INICIAL_POWER_UP_FORCA
    # la t2, SCORE_TIMER                      # Pega o endereco de SCORE_TIMER
	# lw t2, 0(t2)                            # Pega o conteudo de SCORE_TIMER
    # sw t3, 0(t0)
    # j MOVIMENTA_INIMIGOS

    # ## EVENTO: CAIR EM ARMADILHA ##
    # CAIR_EM_ARMADILHA:
    # li t2, 7                            # Pegue o valor 1
    # bne s3, t2, MOVIMENTA_INIMIGOS      # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    # j FIM_GAME_LOOP_FASE_1              # Encerra o jogo	


CASO_TECLA_a:
    li t2, 97		            # Pegue o valor 'a' na tabela ASCII	
    bne s0, t2, CASO_TECLA_s	# Se a tecla pressionada nao foi 'a'
    
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, -1             # Adicone o offset

    lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET

    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_esquerda	# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    ## EVENTO: COLISAO BLOCOS ##
    li t2, 1                            # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    li t2, 4
    sb t2, 0(s1)        # Movimenta o JOGADOR

    addi s1, s1, 1	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador

    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_s:
    li t2, 115		            # Pegue o valor S na tabela ASCII	
    bne s0, t2, CASO_TECLA_d	# Se a tecla pressionada nao foi 's'
    
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_baixo		# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

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

    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR

    addi s1, s1, -20	# Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador

    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_d:
    li t2, 100		            # Pegue o valor 'd' na tabela ASCII	
    bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'd'    # Corrigir PRIMEIRO salto para CASO_TECLA_L, DEPOIS para CASO_TECLA_L

    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_direita	# pega o endereco de "IMAGEM_JOGADOR_direita" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

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
    CASO_2_APAGA_BLOCOS:
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

FIM_ATUALIZA_TILEMAP:

