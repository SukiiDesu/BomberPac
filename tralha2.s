## PRINTA UM OBJETO ##
# t0 = POSICAO_OBJETO
# t5 = ENDERECO INICIAL DA SPRITE DO OBJETO
INICIO_OBJETO:
	li t0, 0
	la t5, VIDA

LOOP_TILEMAP_OBJETO:
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
PREENCHE_MATRIZ_OBJETO:
		# Inicializa linha e ultima linha
		li s0, 0	# Linha inicial = 0
		li s1, 16	# Linha final = 16
# Loop para printar cada linha da matriz
LOOP_LINHAS_MATRIZ_OBJETO:
	beq s0, s1, FIM_OBJETO	# Enquanto i < 16, faca o abaixo
		# Inicializa coluna e ultima coluna
		li t2, 0	# Coluna inicial = 0
		li t3, 16	# t3 = numero de colunas
	# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
	LOOP_COLUNA_OBJETO:			
		beq t2,t3,SOMA_LINHA_OBJETO	# Enquanto coluna < 16
		#PREENCHE_BYTE
		lb t6,0(t5)		# Pegue o byte de cor da imagem
		sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 0)
		sb t6,0(s4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 1)
		addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 0)
		addi s4,s4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 1)
		addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
	
		addi t2,t2,1		# coluna++
		j LOOP_COLUNA_OBJETO		# Retorne para a verificacao do Loop das Colunas

# Etapa de iteracao da linha e de correcao do pixel inicial				
SOMA_LINHA_OBJETO:
	addi s0, s0, 1	# linha ++
	
	# Inicia proxima linha
	addi t4, t4, -16	# Retorne ao primeiro pixel da linha (pro frame 0)
	addi t4, t4, 320	# Passe para a linha abaixo (pro frame 0)
	addi s4, s4, -16	# Retorne ao primeiro pixel da linha (pro frame 1)
	addi s4, s4, 320	# Passe para a linha abaixo (pro frame 1)
	
	j LOOP_LINHAS_MATRIZ_OBJETO	# Retorne para a verificacao do Loop das Linhas Matriz

# Fim_OBJETO do programa
FIM_OBJETO:
