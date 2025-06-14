.data
	.include "variaveis.data"

.text
	la s2, TILEMAP_MUTAVEL
	addi s2, s2, -1
	li t0, 0	# Primeira matriz do tilemap
	li t1, 299	# Ultima matriz do tilemap
LOOP_TILEMAP:
	bgt t0, t1, FIM
		lui t4, 0xFF000
	
		# 0xFF00 + 5120 * t0 // 20
		li t2, 20
		div t2, t0, t2
		li t3, 5120
		mul t2, t3, t2
		add t4, t4, t2
		
		# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
		li t2, 20
		rem t2, t0, t2
		li t3, 16
		mul t2, t3, t2
		add t4, t4, t2

		addi s2, s2, 1
		lb t5, 0(s2)	# Valor da matriz no Tilemap
CASO_0:
		li t2, 0
		bne t5, t2, CASO_1
		la t5, IMAGEM_0
		j PREENCHE_MATRIZ
CASO_1:
		li t2, 1
		bne t5, t2, ITERA_LOOP_TILEMAP
		la t5, IMAGEM_1

PREENCHE_MATRIZ:
		# Inicializa linha e ultima linha
		li s0, 0
		li s1, 16
LOOP_LINHAS_MATRIZ:
	beq s0, s1, ITERA_LOOP_TILEMAP
		# Inicializa coluna e ultima coluna
		li t2, 0	# Coluna inicial
		li t3, 15	# t3 = numero de colunas
	LOOP_COLUNA:			
		beq t2,t3,SOMA_LINHA	# Enquanto coluna < 16
		#PREENCHE_BYTE
		lb t6,0(t5)		# Pegue o byte de cor da imagem
		sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display
		addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte
		addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
	
		addi t2,t2,1		# coluna++
		j LOOP_COLUNA			
				
SOMA_LINHA:
	addi s0, s0, 1	# linha ++
	addi t5, t5, 1	# Proxima linha do Tilemap
	
	#  Inicio proxima linha
	addi t4, t4, -15
	addi t4, t4, 320
	
	j LOOP_LINHAS_MATRIZ
		
ITERA_LOOP_TILEMAP:
		addi t0, t0, 1	# t0++
		j LOOP_TILEMAP 
FIM:
