	la t0, SCORE_TIMER  # Pega o endereco de SCORE_TIMER
	lw t0, 0(t0)        # Pega o conteudo de SCORE_TIMER
	beqz t0, FIM_GAME_LOOP_FASE_1   # Se SCORE_TIMER == 0 -> Encerre a Fase

	# Pega tempo em TEMPO_INICIAL_SCORE_TIMER
	la s2, TEMPO_INICIAL_SCORE_TIMER	# Pega endereco de TEMPO_INICIAL_SCORE_TIMER
	lw s2, 0(s2)                        # Pega o conteudo de TEMPO_INICIAL_SCORE_TIMER

	# Pega tempo atual
	li a7, 30           # Chama a funcao TIME()
	ecall               # Chama o Sistema operacional

	# Pega o tempo passado desde o tempo inicial
	sub t3, a0, s2			# t3 = TEMPO_ATUAL - TEMPO_INICIAL_TESTE

	li t2, 1000     # Constante de comparacao : 1 segundo
	blt t3, t2, PULA_REDUZ_TIMER # Se passou 1 segundo, reduza SCORE_TIMER	
	
	# REDUZ_TIMER : SCORE_TIMER--
	la t0, SCORE_TIMER      # Pega o endereco de SCORE_TIMER
	lw t1, 0(t0)            # Pega o conteudo de SCORE_TIMER
	addi t1, t1, -1         # Subtrai 1 segundo de SCORE_TIMER
	sw t1, 0(t0)            # Atualiza a variavel SCORE_TIMER
	
	# Atualiza TEMPO_INICIAL_SCORE_TIMER
	li a7, 30   # Chama a funcao TIME()
	ecall       # Chama o Sistema operacional
	
	la s2, TEMPO_INICIAL_SCORE_TIMER    # Pega endereco de TEMPO_INICIAL_SCORE_TIMER
	sw a0, 0(s2)                        # Atualiza o conteudo de TEMPO_INICIAL_SCORE_TIMER
	
	
	
	
	
	
	
	### emprime o timer ###
	
	# salva as dezenas, centenas e unidades
	
	# salva valores a serem usados
	li t2, 100			# t2 recebe 100
	li t3, 10			# t3 recebe 10
	
	# salva o digito da centena em s1
	div s1, t1, t2 			# s1 recebe o digito das centenas do timer
	
	#salva o digito das dezenas em s2
	mul t4, s1, t2			# t4 recebe o digito das centenas multiplicado por 100
	sub t4, t1, t4			# t4 recebe o timer, sem as centenas
	div s2, t4, t3			# s2 recebe o digito das dezenas do timer
	
	#salva o digito das unidades em s3
	mul t5, s2, t3			# t5 recebe o digito das dezenas multiplicado por 10
	sub s3, t4, t5			# s3 recebe o digito das unidades do timer
	
	
	
	################################### emprime as centenas ##############################################
	
	#analisa qual eh o numero das centenas
	CASO_CENTENA_0:
			li t2, 0			# Pegue o valor 0
			bne s1, t2, CASO_CENTENA_1	# Compare com o valor das centenas
			la t5, NUMERO_0			# Se o valor das centenas for 0, pegue a imagem do 0
			j INICIO_CENTENA		#printa a centena do timer atual
			
	CASO_CENTENA_1:
			li t2, 1			# Pegue o valor 1
			bne s1, t2, CASO_CENTENA_2	# Compare com o valor das centenas
			la t5, NUMERO_1			# Se o valor das centenas for 1, pegue a imagem do 1
			j INICIO_CENTENA		# printa a centena do timer atual
			
	CASO_CENTENA_2:
			li t2, 2			# Pegue o valor 2
			bne s1, t2, CASO_CENTENA_3	# Compare com o valor das centenas
			la t5, NUMERO_2			# Se o valor das centenas for 2, pegue a imagem do 2
			j INICIO_CENTENA		# printa a centena do timer atual
			
	CASO_CENTENA_3:
			li t2, 3			# Pegue o valor 3
			la t5, NUMERO_3			# Se o valor das centenas for 3, pegue a imagem do 3
			j INICIO_CENTENA		# printa a centena do timer atual						
	
	
	
	
	
	
	## de fato printa centena##
	INICIO_CENTENA:
		li t0, 17
	
	LOOP_TILEMAP_CENTENA:
			lui t4, 0xFF000			# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
			lui s4, 0xFF100
	
			# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)
		
			# 0xFF00 + 5120 * t0 // 20 : 
			li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
			div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
			li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
			mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
			add t4, t4, t2	# Acrescente ao endereco inicial do Frame (pro frame 0)
			add s4, s4, t2  # Acrescente ao endereco inicial do Frame (pro frame 1)
			
			# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
			li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
			rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
			li t3, 16	# 16 eh o tamanho de colunas em um matriz
			mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
			add t4, t4, t2	# Acrescente ao endereco calculado ate agora (pro frame 0)
			add s4, s4, t2  # Acrescente ao endereco calculado ate agora (pro frame 1)
	
	# Matriz eh um conjunto de 16x16 pixels
	# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
	PREENCHE_MATRIZ_CENTENA:
			# Inicializa linha e ultima linha
			li s0, 0	# Linha inicial = 0
			li s1, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_CENTENA:
		beq s0, s1, FIM_CENTENA	# Enquanto i < 16, faca o abaixo
			# Inicializa coluna e ultima coluna
			li t2, 0	# Coluna inicial = 0
			li t3, 16	# t3 = numero de colunas
		# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
		LOOP_COLUNA_CENTENA:			
			beq t2,t3,SOMA_LINHA_CENTENA	# Enquanto coluna < 16
			#PREENCHE_BYTE
			lb t6,0(t5)		# Pegue o byte de cor da imagem
			sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 0)
			sb t6,0(s4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 1)
			addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 0)
			addi s4,s4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 1)
			addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
		
			addi t2,t2,1		# coluna++
			j LOOP_COLUNA_CENTENA		# Retorne para a verificacao do Loop das Colunas
	
	# Etapa de iteracao da linha e de correcao do pixel inicial				
	SOMA_LINHA_CENTENA:
		addi s0, s0, 1	# linha ++
		
		# Inicia proxima linha
		addi t4, t4, -16	# Retorne ao primeiro pixel da linha (pro frame 0)
		addi t4, t4, 320	# Passe para a linha abaixo (pro frame 0)
		addi s4, s4, -16	# Retorne ao primeiro pixel da linha (pro frame 1)
		addi s4, s4, 320	# Passe para a linha abaixo (pro frame 1)
		
		j LOOP_LINHAS_MATRIZ_CENTENA	# Retorne para a verificacao do Loop das Linhas Matriz
	
	# Fim_CENTENA do programa
	FIM_CENTENA:
	
	
	
	
	
	
	################################## emprime as dezenas ################################################
	
	#analisa qual eh o numero das centenas
	CASO_DEZENA_0:
			li t2, 0			# Pegue o valor 0
			bne s2, t2, CASO_DEZENA_1	# Compare com o valor das dezenas
			la t5, NUMERO_0			# Se o valor das dezenas for 0, pegue a imagem do 0
			j INICIO_DEZENA			#printa a dezena do timer atual
				
	CASO_DEZENA_1:
			li t2, 1			# Pegue o valor 1
			bne s2, t2, CASO_DEZENA_2	# Compare com o valor das dezenas
			la t5, NUMERO_1			# Se o valor das dezenas for 1, pegue a imagem do 1
			j INICIO_DEZENA			# printa a dezena do timer atual
			
	CASO_DEZENA_2:
			li t2, 2			# Pegue o valor 2
			bne s2, t2, CASO_DEZENA_3	# Compare com o valor das dezenas
			la t5, NUMERO_2			# Se o valor das dezenas for 2, pegue a imagem do 2
			j INICIO_DEZENA			# printa a dezena do timer atual
			
	CASO_DEZENA_3:
			li t2, 3			# Pegue o valor 3
			bne s2, t2, CASO_DEZENA_4	# Compare com o valor das dezenas
			la t5, NUMERO_3			# Se o valor das dezenas for 3, pegue a imagem do 3
			j INICIO_DEZENA			#printa a dezena do timer atual
				
	CASO_DEZENA_4:
			li t2, 4			# Pegue o valor 4
			bne s2, t2, CASO_DEZENA_5	# Compare com o valor das dezenas
			la t5, NUMERO_4			# Se o valor das dezenas for 4, pegue a imagem do 4
			j INICIO_DEZENA			# printa a dezena do timer atual
			
	CASO_DEZENA_5:
			li t2, 5			# Pegue o valor 5
			bne s2, t2, CASO_DEZENA_6	# Compare com o valor das dezenas
			la t5, NUMERO_5			# Se o valor das dezenas for 5, pegue a imagem do 5
			j INICIO_DEZENA			# printa a dezena do timer atual
			
	CASO_DEZENA_6:
			li t2, 6			# Pegue o valor 6
			bne s2, t2, CASO_DEZENA_7	# Compare com o valor das dezenas
			la t5, NUMERO_6			# Se o valor das dezenas for 6, pegue a imagem do 6
			j INICIO_DEZENA			# printa a dezena do timer atual
			
	CASO_DEZENA_7:
			li t2, 7			# Pegue o valor 7
			bne s2, t2, CASO_DEZENA_8	# Compare com o valor das dezenas
			la t5, NUMERO_7			# Se o valor das dezenas for 7, pegue a imagem do 7
			j INICIO_DEZENA			# printa a dezena do timer atual
			
	CASO_DEZENA_8:
			li t2, 8			# Pegue o valor 8
			bne s2, t2, CASO_DEZENA_9	# Compare com o valor das dezenas
			la t5, NUMERO_8			# Se o valor das dezenas for 8, pegue a imagem do 8
			j INICIO_DEZENA			# printa a dezena do timer atual																														
			
	CASO_DEZENA_9:
			li t2, 9			# Pegue o valor 9
			la t5, NUMERO_9			# Se o valor das dezenas for 9, pegue a imagem do 9
			j INICIO_DEZENA			# printa a dezena do timer atual						
	
	
	
	
	
	
	## de fato printa dezenas##
	INICIO_DEZENA:
		li t0, 18
	
	LOOP_TILEMAP_DEZENA:
			lui t4, 0xFF000			# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
			lui s4, 0xFF100
	
			# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)
		
			# 0xFF00 + 5120 * t0 // 20 : 
			li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
			div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
			li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
			mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
			add t4, t4, t2	# Acrescente ao endereco inicial do Frame (pro frame 0)
			add s4, s4, t2  # Acrescente ao endereco inicial do Frame (pro frame 1)
			
			# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
			li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
			rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
			li t3, 16	# 16 eh o tamanho de colunas em um matriz
			mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
			add t4, t4, t2	# Acrescente ao endereco calculado ate agora (pro frame 0)
			add s4, s4, t2  # Acrescente ao endereco calculado ate agora (pro frame 1)
	
	# Matriz eh um conjunto de 16x16 pixels
	# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
	PREENCHE_MATRIZ_DEZENA:
			# Inicializa linha e ultima linha
			li s0, 0	# Linha inicial = 0
			li s1, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_DEZENA:
		beq s0, s1, FIM_DEZENA	# Enquanto i < 16, faca o abaixo
			# Inicializa coluna e ultima coluna
			li t2, 0	# Coluna inicial = 0
			li t3, 16	# t3 = numero de colunas
		# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
		LOOP_COLUNA_DEZENA:			
			beq t2,t3,SOMA_LINHA_DEZENA	# Enquanto coluna < 16
			#PREENCHE_BYTE
			lb t6,0(t5)		# Pegue o byte de cor da imagem
			sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 0)
			sb t6,0(s4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 1)
			addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 0)
			addi s4,s4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 1)
			addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
		
			addi t2,t2,1		# coluna++
			j LOOP_COLUNA_DEZENA		# Retorne para a verificacao do Loop das Colunas
	
	# Etapa de iteracao da linha e de correcao do pixel inicial				
	SOMA_LINHA_DEZENA:
		addi s0, s0, 1	# linha ++
		
		# Inicia proxima linha
		addi t4, t4, -16	# Retorne ao primeiro pixel da linha (pro frame 0)
		addi t4, t4, 320	# Passe para a linha abaixo (pro frame 0)
		addi s4, s4, -16	# Retorne ao primeiro pixel da linha (pro frame 1)
		addi s4, s4, 320	# Passe para a linha abaixo (pro frame 1)
		
		j LOOP_LINHAS_MATRIZ_DEZENA	# Retorne para a verificacao do Loop das Linhas Matriz
	
	# Fim_DEZENA do programa
	FIM_DEZENA:
	
	
	
	
	######################################### emprime as unidades #################################################
	
	#analisa qual eh o numero das unidades
	CASO_UNIDADE_0:
			li t2, 0			# Pegue o valor 0
			bne s3, t2, CASO_UNIDADE_1	# Compare com o valor das unidades
			la t5, NUMERO_0			# Se o valor das unidades for 0, pegue a imagem do 0
			j INICIO_UNIDADE		#printa a unidade do timer atual
				
	CASO_UNIDADE_1:
			li t2, 1			# Pegue o valor 1
			bne s3, t2, CASO_UNIDADE_2	# Compare com o valor das unidades
			la t5, NUMERO_1			# Se o valor das unidades for 1, pegue a imagem do 1
			j INICIO_UNIDADE		# printa a unidade do timer atual
			
	CASO_UNIDADE_2:
			li t2, 2			# Pegue o valor 2
			bne s3, t2, CASO_UNIDADE_3	# Compare com o valor das unidades
			la t5, NUMERO_2			# Se o valor das unidades for 2, pegue a imagem do 2
			j INICIO_UNIDADE		# printa a unidade do timer atual
			
	CASO_UNIDADE_3:
			li t2, 3			# Pegue o valor 3
			bne s3, t2, CASO_UNIDADE_4	# Compare com o valor das unidades
			la t5, NUMERO_3			# Se o valor das unidades for 3, pegue a imagem do 3
			j INICIO_UNIDADE		#printa a unidade do timer atual
				
	CASO_UNIDADE_4:
			li t2, 4			# Pegue o valor 4
			bne s3, t2, CASO_UNIDADE_5	# Compare com o valor das unidades
			la t5, NUMERO_4			# Se o valor das unidades for 4, pegue a imagem do 4
			j INICIO_UNIDADE		# printa a unidade do timer atual
			
	CASO_UNIDADE_5:
			li t2, 5			# Pegue o valor 5
			bne s3, t2, CASO_UNIDADE_6	# Compare com o valor das unidades
			la t5, NUMERO_5			# Se o valor das unidades for 5, pegue a imagem do 5
			j INICIO_UNIDADE		# printa a unidade do timer atual
			
	CASO_UNIDADE_6:
			li t2, 6			# Pegue o valor 6
			bne s3, t2, CASO_UNIDADE_7	# Compare com o valor das unidades
			la t5, NUMERO_6			# Se o valor das unidades for 6, pegue a imagem do 6
			j INICIO_UNIDADE		# printa a unidade do timer atual
			
	CASO_UNIDADE_7:
			li t2, 7			# Pegue o valor 7
			bne s3, t2, CASO_UNIDADE_8	# Compare com o valor das unidades
			la t5, NUMERO_7			# Se o valor das unidades for 7, pegue a imagem do 7
			j INICIO_UNIDADE		# printa a unidade do timer atual
			
	CASO_UNIDADE_8:
			li t2, 8			# Pegue o valor 8
			bne s3, t2, CASO_UNIDADE_9	# Compare com o valor das unidades
			la t5, NUMERO_8			# Se o valor das unidades for 8, pegue a imagem do 8
			j INICIO_UNIDADE		# printa a unidade do timer atual																														
			
	CASO_UNIDADE_9:
			li t2, 9			# Pegue o valor 9
			la t5, NUMERO_9			# Se o valor das unidades for 9, pegue a imagem do 9
			j INICIO_UNIDADE		# printa a unidade do timer atual						
	
	
	
	
	
	
	## de fato printa unidades##
	INICIO_UNIDADE:
		li t0, 19
	
	LOOP_TILEMAP_UNIDADE:
			lui t4, 0xFF000			# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
			lui s4, 0xFF100
	
			# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)
		
			# 0xFF00 + 5120 * t0 // 20 : 
			li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
			div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
			li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
			mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
			add t4, t4, t2	# Acrescente ao endereco inicial do Frame (pro frame 0)
			add s4, s4, t2  # Acrescente ao endereco inicial do Frame (pro frame 1)
			
			# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
			li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
			rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
			li t3, 16	# 16 eh o tamanho de colunas em um matriz
			mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
			add t4, t4, t2	# Acrescente ao endereco calculado ate agora (pro frame 0)
			add s4, s4, t2  # Acrescente ao endereco calculado ate agora (pro frame 1)
	
	# Matriz eh um conjunto de 16x16 pixels
	# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
	PREENCHE_MATRIZ_UNIDADE:
			# Inicializa linha e ultima linha
			li s0, 0	# Linha inicial = 0
			li s1, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_UNIDADE:
		beq s0, s1, FIM_UNIDADE	# Enquanto i < 16, faca o abaixo
			# Inicializa coluna e ultima coluna
			li t2, 0	# Coluna inicial = 0
			li t3, 16	# t3 = numero de colunas
		# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
		LOOP_COLUNA_UNIDADE:			
			beq t2,t3,SOMA_LINHA_UNIDADE	# Enquanto coluna < 16
			#PREENCHE_BYTE
			lb t6,0(t5)		# Pegue o byte de cor da imagem
			sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 0)
			sb t6,0(s4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 1)
			addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 0)
			addi s4,s4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 1)
			addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
		
			addi t2,t2,1		# coluna++
			j LOOP_COLUNA_UNIDADE		# Retorne para a verificacao do Loop das Colunas
	
	# Etapa de iteracao da linha e de correcao do pixel inicial				
	SOMA_LINHA_UNIDADE:
		addi s0, s0, 1	# linha ++
		
		# Inicia proxima linha
		addi t4, t4, -16	# Retorne ao primeiro pixel da linha (pro frame 0)
		addi t4, t4, 320	# Passe para a linha abaixo (pro frame 0)
		addi s4, s4, -16	# Retorne ao primeiro pixel da linha (pro frame 1)
		addi s4, s4, 320	# Passe para a linha abaixo (pro frame 1)
		
		j LOOP_LINHAS_MATRIZ_UNIDADE	# Retorne para a verificacao do Loop das Linhas Matriz
	
	# Fim_UNIDADE do programa
	FIM_UNIDADE:
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

PULA_REDUZ_TIMER:	
